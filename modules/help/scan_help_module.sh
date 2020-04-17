#!/bin/bash
source pakuri.conf

function help_scan()
{
    clear
    echo -e "${BLUE_b}+---+"
    echo -e "${BLUE_b}| 1 |  Scanning"
    echo -e "${BLUE_b}+---+${NC}"
    echo -e "${BOLD}-------------------Scan Menu Assist-------------------${NC}"
    echo -e ""
    echo -e "${BLUE_b}+---+"
    echo -e "${BLUE_b}| 1 |  Port Scan"
    echo -e "${BLUE_b}+---+"
    echo -e "------------------------------------------------------${NC}"
    echo -e "Various scans are performed using Nmap's features."
    echo -e "   ${BLUE_b}[1]${NC} Port Scan"
    echo -e "   ${RED_b}[2]${NC} Vulners Scan"
    echo -e ""
    echo -e ""
    echo -e "${RED_b}+---+"
    echo -e "${RED_b}| 2 |  Enumeration"
    echo -e "${RED_b}+---+"
    echo -e "------------------------------------------------------${NC}"
    echo -e "Perform enumeration for services that are open."
    echo -e ""
    echo -e ""
    echo -e "${YELLOW_b}+---+"
    echo -e "${YELLOW_b}| 3 |  OpenVAS"
    echo -e "${YELLOW_b}+---+"
    echo -e "------------------------------------------------------${NC}"
    echo -e "Vulnerability scanning using OpenVAS."
    echo -e ""
    echo -e ""
}

function help_portscan()
{
    clear
    echo -e ""
    echo -e "${BLUE_b}+---+  +---+  +---+"
    echo -e "${BLUE_b}| 1 |  | 1 |  | 1 |  Port Scan"
    echo -e "${BLUE_b}+---+  +---+  +---+${NC}"
    echo -e "${BOLD}------------------------------------------------------${NC}"
    echo -e "Overview"
    echo -e "   Use Nmap to perform a port scan."
    echo -e ""
    echo -e "${GREEN_b}Step 1${NC}"
    echo -e "   First, use the following command to store the freed port number in a variable(PORT)."
    echo -e ""
    echo -e "Use Command:"
    echo -e "   nmap -Pn -p- -v --min-rate=1000 -T4 <IP Address>"
    echo -e "Options:"
    echo -e "   -Pn: Treat all hosts as online -- skip host discovery"
    echo -e "   -p <port ranges>: Only scan specified ports"
    echo -e "   -v: Increase verbosity level (use -vv or more for greater effect)"
    echo -e "   --min-rate <number>: Send packets no slower than <number> per second"
    echo -e "   -T<0-5>: Set timing template (higher is faster)"
    echo -e ""
    echo -e "${GREEN_b}Step 2${NC}"
    echo -e "   Next, we run a scan on the freed port using the previous variable(PORT)."
    echo -e ""
    echo -e "Use Command:"
    echo -e "   nmap -sV -v --script= *vuln* -p\$PORT <IP Address> -oN <.nmap file> -oG <.grep file>"
    echo -e "Options:"
    echo -e "   -sV: Probe open ports to determine service/version info"
    echo -e "   --script=<Lua scripts>: <Lua scripts> is a comma separated list of"
    echo -e "       directories, script-files or script-categories"
    echo -e "   -oN/-oX/-oS/-oG <file>: Output scan in normal, XML, s|<rIpt kIddi3,"
    echo -e "       and Grepable format, respectively, to the given filename."
    echo -e ""
}

function help_vulnerscan()
{
    clear
    echo -e ""
    echo -e "${BLUE_b}+---+  +---+  ${RED_b}+---+"
    echo -e "${BLUE_b}| 1 |  | 1 |  ${RED_b}| 2 |  Vulners Scan"
    echo -e "${BLUE_b}+---+  +---+  ${RED_b}+---+${NC}"
    echo -e "${BOLD}------------------------------------------------------${NC}"
    echo -e "Overview"
    echo -e "   Use NSE scripts(nmap_vulners) to enumerate known vulnerability information."
    echo -e ""
    echo -e "${GREEN_b}Step 1${NC}"
    echo -e "   First, use the following command to store the freed port number in a variable(PORT)."
    echo -e ""
    echo -e "Use Command:"
    echo -e "   nmap -Pn -p- -v --min-rate=1000 -T4 <IP Address>"
    echo -e "Options:"
    echo -e "   -Pn: Treat all hosts as online -- skip host discovery"
    echo -e "   -p <port ranges>: Only scan specified ports"
    echo -e "   -v: Increase verbosity level (use -vv or more for greater effect)"
    echo -e "   --min-rate <number>: Send packets no slower than <number> per second"
    echo -e "   -T<0-5>: Set timing template (higher is faster)"
    echo -e ""
    echo -e "${GREEN_b}Step 2${NC}"
    echo -e "   Next, we enumerate the known vulnerabilities of the freed ports using the previous variable(PORT)."
    echo -e ""
    echo -e "Use Command:"
    echo -e "   nmap -Pn -v -sV --max-retries 1 --max-scan-delay 20 --script vulners --script-args mincvss=6.0 -p\$PORT <IP Address> -oN <.nmap file>"
    echo -e "Options:"
    echo -e "   -sV: Probe open ports to determine service/version info"
    echo -e "   --script=<Lua scripts>: <Lua scripts> is a comma separated list of"
    echo -e "       directories, script-files or script-categories"
    echo -e "   --script-args=<n1=v1,[n2=v2,...]>: provide arguments to scripts"
    echo -e "   -oN/-oX/-oS/-oG <file>: Output scan in normal, XML, s|<rIpt kIddi3,"
    echo -e "       and Grepable format, respectively, to the given filename."
    echo -e ""
}

function help_enumeration()
{
    clear
    echo -e ""
    echo -e "${BLUE_b}+---+  ${RED_b}+---+"
    echo -e "${BLUE_b}| 1 |  ${RED_b}| 2 |  Enumeration"
    echo -e "${BLUE_b}+---+  ${RED_b}+---+${NC}"
    echo -e "${BOLD}------------------------------------------------------${NC}"
    echo -e "Overview"
    echo -e "   Use the various commands to enumerate against the open ports."
    echo -e ""
    echo -e "${GREEN_b}SSH${NC}"
    echo -e "Use Command:"
    echo -e "   nmap -sV -p <Target Port> --script='banner,ssh2-enum-algos,ssh-hostkey,ssh-auth-methods' <IP Address>"
    echo -e "Result:"
    echo -e "   $WDIR/ssh_<IP Address>:<SSH Port>.nmap"
    echo -e ""
    echo -e "${GREEN_b}HTTP${NC}"
    echo -e "Use Commands:"
    echo -e "   nikto -h http://<IP Address>:<HTTP Port> "
    echo -e "   skipfish -U -u -Q -t 12 -W- -o $WDIR/skipfish_<IP Address>_<HTTP Port> http://<IP Address>:<HTTP Port>"
    echo -e "Results:"
    echo -e "   $WDIR/nikto_<IP Address>:<HTTP Port>.txt"
    echo -e "   $WDIR/skipfish_<IP Address>_<HTTP Port>/index.html"
    echo -e ""
    echo -e "${GREEN_b}HTTPS${NC}"
    echo -e "Use Commands:"
    echo -e "   nikto -h https://<IP Address>:<HTTPS Port> "
    echo -e "   skipfish -U -u -Q -t 12 -W- -o $WDIR/skipfish_<IP Address>_<HTTPS Port> https://<IP Address>:<HTTPS Port>"
    echo -e "   sslyze --regular <IP Address>"
    echo -e "   sslscan <IP Address>"
    echo -e "Results:"
    echo -e "   $WDIR/nikto_<IP Address>:<HTTP Port>.txt"
    echo -e "   $WDIR/skipfish_<IP Address>_<HTTP Port>/index.html"
    echo -e "   $WDIR/sslscan_<IP Address>.txt"
    echo -e ""
    echo -e "${GREEN_b}netbios-ssn${NC}|${GREEN_b}microsoft-ds${NC}"
    echo -e "Use Commnads:"
    echo -e "   nmap -sV -p <Target Port> --script='*smb-vuln* and not brute or broadcast or dos or external or fuzzer' <IP Address>" 
    echo -e "   enum4linux -a -M -1 -d <IP Address>"
    echo -e "Results:"
    echo -e "   $WDIR/smb_<IP Address>:<Target Port>.nmap"
    echo -e "   $WDIR/enum4linux_<IP Address>.txt"
    echo -e ""
}

function help_openvas()
{
    clear
    echo -e ""
    echo -e "${BLUE_b}+---+  ${YELLOW_b}+---+"
    echo -e "${BLUE_b}| 1 |  ${YELLOW_b}| 3 |  OpenVAS"
    echo -e "${BLUE_b}+---+  ${YELLOW_b}+---+${NC}"
    echo -e "${BOLD}------------------------------------------------------${NC}"
    echo -e "Overview"
    echo -e "   Use the OpenVAS Management Protocol (OMP) to perform a vulnerability scan."
    echo -e "   The entire control of the Greenbone Security Manager (GSM) appliance is done via the OpenVAS Management Protocol (OMP)."
    echo -e "   The web interface is an OMP client as well and accesses the GSM functions via OMP."
    echo -e ""
    echo -e "${GREEN_b}Step 1${NC} Create Targets"
    echo -e "Use Commnads:"
    echo -e "   omp -X '<create_target><name>[TARGET_NAME]</name><hosts>[Target hosts]</hosts></create_target>' -u [OMPUSER] -w [OMPPASS]"
    echo -e "Options:"
    echo -e "   -u: OMP username"
    echo -e "   -w: OMP password"
    echo -e ""
    echo -e "${GREEN_b}Step 2${NC} Create Task"
    echo -e "Use Commnads:"
    echo -e "   omp -C -c daba56c8-73ec-11df-a475-002264764cea --name [TASK_NAME] --target [TARGET_ID] -u [OMPUSER] -w [OMPPASS]"
    echo -e "Options:"
    echo -e "   -C: Create a task."
    echo -e "   -c: Config for create-task."
    echo -e "   configs:"
    echo -e "       8715c877-47a0-438d-98a3-27c7a6ab2196  Discovery"
    echo -e "       085569ce-73ed-11df-83c3-002264764cea  empty"
    echo -e "       daba56c8-73ec-11df-a475-002264764cea  Full and fast"
    echo -e "       698f691e-7489-11df-9d8c-002264764cea  Full and fast ultimate"
    echo -e "       708f25c4-7489-11df-8094-002264764cea  Full and very deep"
    echo -e "       74db13d6-7489-11df-91b9-002264764cea  Full and very deep ultimate"
    echo -e "       2d3f051c-55ba-11e3-bf43-406186ea4fc5  Host Discovery"
    echo -e "       bbca7412-a950-11e3-9109-406186ea4fc5  System Discovery"
    echo -e "   --name: name for create-task."
    echo -e "   --target: target for create-task."
    echo -e ""
    echo -e "${GREEN_b}Step 3${NC} Start Task"
    echo -e "Use Commnads:"
    echo -e "   omp -S [TASK_ID] -u [OMPUSER] -w [OMPPASS]"
    echo -e "Options:"
    echo -e "   -S: Start one or more tasks."
    echo -e ""
    echo -e "${GREEN_b}Step 4${NC} Report"
    echo -e "Use Commnads:"
    echo -e "   omp --get-report [REPORT_ID] --format c402cc3e-b531-11e1-9163-406186ea4fc5 -u [OMPUSER] -w [OMPPASS] > [report].pdf"
    echo -e "Options:"
    echo -e "   --get-report: Report-ID for output. "
    echo -e "   --format: report-formats"
    echo -e "       910200ca-dc05-11e1-954f-406186ea4fc5  ARF"
    echo -e "       5ceff8ba-1f62-11e1-ab9f-406186ea4fc5  CPE"
    echo -e "       9087b18c-626c-11e3-8892-406186ea4fc5  CSV Hosts"
    echo -e "       c1645568-627a-11e3-a660-406186ea4fc5  CSV Results"
    echo -e "       35ba7077-dc85-42ef-87c9-b0eda7e903b6  GSR PDF"
    echo -e "       ebbc7f34-8ae5-11e1-b07b-001f29eadec8  GXR PDF"
    echo -e "       6c248850-1f62-11e1-b082-406186ea4fc5  HTML"
    echo -e "       77bd6c4a-1f62-11e1-abf0-406186ea4fc5  ITG"
    echo -e "       a684c02c-b531-11e1-bdc2-406186ea4fc5  LaTeX"
    echo -e "       9ca6fe72-1f62-11e1-9e7c-406186ea4fc5  NBE"
    echo -e "       c402cc3e-b531-11e1-9163-406186ea4fc5  PDF"
    echo -e "       9e5e5deb-879e-4ecc-8be6-a71cd0875cdd  Topology SVG"
    echo -e "       a3810a62-1f62-11e1-9219-406186ea4fc5  TXT"
    echo -e "       a994b278-1f62-11e1-96ac-406186ea4fc5  XML"
    echo -e ""
}

case $1 in
    main)
        help_scan;;
    111)
        help_portscan;;
    112)
        help_vulnerscan;;
    12)
        help_enumeration;;
    13)
        help_openvas;;
esac