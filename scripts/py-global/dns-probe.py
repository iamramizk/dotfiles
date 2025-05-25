import sys
import os
import json
import pty
from rich.padding import Padding
from rich.align import Align
from rich.console import Console
from rich.table import Table
from rich import box


DNS_SERVER = f"8.8.8.8"
LOOKUP_TYPES = "MX,TXT,CNAME,TXT,NS,A,AAAA"

MX_SELECTOR_MAP = {
    "google": ["google"],  # Google Workspace (G Suite)
    "outlook.com": ["selector1", "selector2"],  # Microsoft 365 / Office 365
    "mail.protection.outlook.com": ["selector1", "selector2"],  # Microsoft 365 / Office 365
    "sendgrid.net": ["s1"],  # SendGrid
    "everlytic": ["everlytickey1", "everlytickey2"],  # Everlytic
    "zendesk": ["zendesk1", "zendesk2"],  # Zendesk
    "constantcontact": ["ctct1", "ctct2"],  # Constant Contact
    "mailchimp": ["k1"],  # Mailchimp / Mandrill
    "mandrillapp.com": ["k1"],  # Mailchimp / Mandrill
    "amazonses.com": ["default"],  # Amazon SES
    "exacttarget.com": ["et"],  # Salesforce Marketing Cloud (ExactTarget)
    "sparkpostmail.com": ["s1"],  # SparkPost
    "mailgun.org": ["mailo"],  # Mailgun
    "pm.mtasv.net": ["pm"],  # Postmark
    "hubspotemail.net": ["hs"],  # HubSpot
    "googlemail.com": ["google"],  # Google (legacy)
    "yahoodns.net": ["selector1"],  # Yahoo Small Business
    "aol.com": ["selector1"],  # AOL
    "zoho.com": ["zoho"],  # Zoho Mail
    "sendinblue.com": ["sib"],  # Sendinblue
    "brevo.com": ["sib"],  # Brevo (formerly Sendinblue)
    "mailerlite.com": ["ml"],  # MailerLite
    "activehosted.com": ["ac"],  # ActiveCampaign
    "cmail1.com": ["cm"],  # Campaign Monitor
    "constantcontact.com": ["ctct1", "ctct2"],  # Constant Contact (alternative domains)
    "hotmail.com": ["selector1", "selector2"],  # Outlook.com legacy
    "emailsrvr.com": ["rackspace"],  # Rackspace
    "fastmail.com": ["fm"],  # Fastmail
    "protonmail.ch": ["protonmail"],  # ProtonMail
    "gmx.com": ["gmx"],  # GMX
    "yandex.net": ["yandex"],  # Yandex
    "mailjet.com": ["mj"],  # Mailjet
    "posteo.de": ["posteo"],  # Posteo
    "outlook365.com": ["selector1", "selector2"],  # Outlook365 (some tenants)
}

console = Console()
TERMINAL_WIDTH = os.get_terminal_size()[0] - 1

def print_panel(title: str) -> None:
    """Prints header pannel"""
    print()
    centered = Align(title, align="center")
    console.print(Padding(centered, (1, 4), style="bold cyan on black"))


def print_table(data: dict):
    """
    Prints all DNS answers from the response data in a single Rich table.
    Only answers whose 'type' matches the question's 'type' are included.
    Multiple answers appear on separate rows.

    Args:
        data (dict): Parsed JSON DNS response data.
    """
    table = Table(expand=True, width=TERMINAL_WIDTH, box=box.SIMPLE, show_lines=True)

    table.add_column("Name", style="bold green", no_wrap=True)
    table.add_column("Type", style="magenta")
    table.add_column("Class", style="dim")
    table.add_column("TTL", style="yellow")
    table.add_column("Data", style="white")
    # table.add_column("Nameserver", style="dim")

    any_answers = False

    for response in data.get("responses", []):
        question = response.get("questions", [{}])[0]
        q_type = question.get("type", "")

        answers = response.get("answers")
        if not answers:
            continue

        # Filter answers matching question type
        filtered_answers = [a for a in answers if a.get("type") == q_type]
        if not filtered_answers:
            continue

        any_answers = True
        for answer in filtered_answers:
            data_field = answer.get("address") or answer.get("mname") or answer.get("status") or ""
            table.add_row(
                answer.get("name", ""),
                answer.get("type", ""),
                answer.get("class", ""),
                answer.get("ttl", ""),
                data_field,
                # answer.get("nameserver", ""),
            )

    if any_answers:
        console.print(table)
    else:
        console.print("\n  [!] No matching records found\n", style="bold red")



def run_command(command: list, silent=False):
    """
    Runs a command in a pseudo-terminal (PTY) so it produces colored/formatted output.
    Prints output live to terminal unless silent=True.
    Returns the full output (including colors) as a string.
    
    Args:
        command (list or str): Command to run.
        silent (bool): If True, do not print output live.
        
    Returns:
        str: The full output captured from the command.
    """
    output_chunks = []


    def read(fd):
        try:
            data = os.read(fd, 1024)
        except OSError:
            return b''
        if data:
            if not silent:
                print(data.decode(errors='ignore'), end='', flush=True)
            output_chunks.append(data)
        return data

    if isinstance(command, str):
        # Run command in shell
        pid, fd = pty.fork()
        if pid == 0:
            os.execvp("sh", ["sh", "-c", command])
    else:
        # Run command as list of args
        pid, fd = pty.fork()
        if pid == 0:
            os.execvp(command[0], command)

    # Parent process: read from PTY until EOF
    try:
        while True:
            if read(fd) == b'':
                break
    except OSError:
        pass
    finally:
        os.close(fd)

    return b''.join(output_chunks).decode(errors='ignore')

def check_all_records(domain: str):
    """Prints all DNS records found (not including DMARC + DKIM)"""
    print_panel("DNS Records Found")
    cmd_all_records = f"doggo -t {LOOKUP_TYPES} {domain} @{DNS_SERVER} -J"
    response = json.loads(run_command(cmd_all_records.split(), silent=True))
    
    print_table(response)




def check_dmarc(domain: str) -> None:
    """
    Check if a DMARC TXT record exists for the specified domain.

    This function queries the DNS TXT record for `_dmarc.<domain>` using the `doggo` command-line tool.
    It performs two queries:
      1. A JSON-formatted query to check for the presence of a DMARC TXT record.
      2. If found, a normal query to print the DMARC record details to the console.

    If a DMARC record is found, it prints a styled panel and the DMARC record, then returns True.
    If no DMARC record is found or an error occurs during the query, it returns False.

    Args:
        domain (str): The domain name to check for a DMARC record.
    """
    cmd = f"doggo TXT _dmarc.{domain.strip()} @{DNS_SERVER}"
    cmd_json = cmd + " -J"
    response = json.loads(run_command(cmd_json.split(), silent=True))
    print_panel("DMARC")
    print_table(response)

def check_dkim(domain: str): 
    """
    Check for DKIM selectors associated with the domain's MX records and display their TXT records.

    This function performs the following steps:
    1. Queries the MX records for the given domain using the `doggo` tool with JSON output.
    2. Extracts the MX addresses from the response.
    3. Uses a predefined mapping (`MX_SELECTOR_MAP`) to loosely match known email providers 
       based on MX addresses and find their common DKIM selectors.
    4. For each detected selector, prints a styled panel and queries the corresponding DKIM TXT record,
       displaying the results in the console.

    Args:
        domain (str): The domain name to check for DKIM selectors.

    Returns:
        None

    Note:
        This function prints output directly to the console if a value is returned.
    """
    mx_command = f"doggo MX {domain} @{DNS_SERVER} -J"
    response = json.loads(run_command(mx_command.split(), silent=True))

    def find_selectors_from_addresses(addresses: list) -> list:
        """
        Given a list of MX addresses, loosely find and return selectors from MX_SELECTOR_MAP.
        
        Args:
            addresses (list of str): MX addresses to check.
            
        Returns:
            list of str: List of selectors found (no duplicates).
        """
        found_selectors = set()
        addresses_lower = [addr.lower() for addr in addresses]

        for key, selectors in MX_SELECTOR_MAP.items():
            for addr in addresses_lower:
                if key in addr:
                    found_selectors.update(selectors)
                    break  # Stop checking this key once matched

        return list(found_selectors)

    print_panel("DKIM")
    default_command = f"doggo TXT default._domainkey.{domain} @{DNS_SERVER} -J"
    default_response = json.loads(run_command(default_command.split(), silent=True))
    try: # try default dkim
        if default_response["responses"][0]["answers"][0]["type"] == "TXT":
            print_table(default_response)
    except:
        console.print("\n  [!] No default selectors found\n", style="bold red")

    try: # try selector dkim
        addresses = [answer["address"] for answer in response["responses"][0]["answers"]]
        selectors = find_selectors_from_addresses(addresses)
        if not selectors:
            console.print("\n  [!] No selectors found from MX records\n", style="bold red")
            return

        for selector in selectors:
            cmd_dkim = f"doggo TXT {selector}._domainkey.{domain} @{DNS_SERVER} -J"
            selector_response = json.loads(run_command(cmd_dkim.split(), silent=True))
            print_table(selector_response)
    except:
        console.print("\n  [!] No selectors found from MX records\n", style="bold red")



if __name__ == "__main__":
    args = sys.argv
    if not len(args) > 1:
        console.print("\n  [!] Must provide domain name as arg\n", style="bold red")
        exit(1)

    domain = args[1].strip()

    check_all_records(domain)
    check_dkim(domain)
    check_dmarc(domain)
