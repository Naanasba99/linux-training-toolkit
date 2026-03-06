#!/usr/bin/env bash

# ================================================================
#  RITUEL QUOTIDIEN — OPERATEUR LINUX / CYBER (MODE INTERACTIF)
#
#  Ce script représente mon rituel d'élite quotidien.
#  Je le lance au moins une fois par jour pour :
#    - sentir l'état réel de la machine
#    - développer mes réflexes d'observation
#    - détecter les anomalies avant tout le monde
#    - renforcer ma vision Red Team + Blue Team
#
#  Mode interactif :
#    → une étape à la fois
#    → je décide quand lancer chaque check
#    → je peux quitter à tout moment avec 'q'
# ================================================================

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

section() {
    echo -e "\n${BOLD}${MAGENTA}========== $1 ==========${RESET}\n"
}

coach() {
    echo -e "${BLUE}Coach:${RESET} $1"
}

cmd_info() {
    echo -e "${CYAN}$ $1${RESET}"
}

line() {
    echo -e "${YELLOW}----------------------------------------------------------------${RESET}"
}

press_to_continue() {
    echo
    read -r -p "👉 ENTER pour lancer cette étape, ou 'q' pour quitter le rituel : " answer
    if [ "$answer" = "q" ] || [ "$answer" = "Q" ]; then
        echo -e "${RED}Rituel interrompu.${RESET}"
        exit 0
    fi
    echo
}

# ------------------ RITUELS (FONCTIONS) --------------------------

rituel_1_uptime() {
    section "1) UPTIME — Est-ce que la machine a bien vécu ?"
    cmd_info "uptime"
    uptime
    coach "Lis la charge (load average) et l'uptime. Un reboot inattendu = alerte. Une charge anormale = question."
    line
}

rituel_2_topcpu() {
    section "2) TOP CPU — Qui tire sur la machine ?"
    cmd_info "ps aux --sort=-%cpu | head -10"
    ps aux --sort=-%cpu | head -10
    coach "Les premières lignes montrent ce qui consomme le plus. Demande-toi si c'est cohérent avec ton usage."
    line
}

rituel_3_logs() {
    section "3) ERREURS CRITIQUES — journalctl -p err -n 20"
    if command -v journalctl >/dev/null 2>&1; then
        cmd_info "journalctl -p err -n 20"
        journalctl -p err -n 20 2>/dev/null || echo "Pas d'erreurs critiques récentes ou accès limité."
    else
        echo "journalctl indisponible sur ce système."
    fi
    coach "Les erreurs critiques racontent ce que la machine a subi : crashs, services qui tombent, disques qui souffrent."
    line
}

rituel_4_lastb() {
    section "4) TENTATIVES DE CONNEXION ÉCHOUÉES — lastb | head"
    if command -v lastb >/dev/null 2>&1; then
        cmd_info "lastb | head"
        lastb | head || echo "Aucune entrée dans btmp (ou droits insuffisants)."
    else
        echo "lastb indisponible sur ce système."
    fi
    coach "C'est ton radar Blue Team. Des IP bizarres, des comptes inconnus = signes d'attaque ou de brute force."
    line
}

rituel_5_ports() {
    section "5) PORTS OUVERTS — ss -tulpn | head -20"
    if command -v ss >/dev/null 2>&1; then
        cmd_info "ss -tulpn | head -20"
        ss -tulpn | head -20
    elif command -v netstat >/dev/null 2>&1; then
        cmd_info "netstat -tulpn | head -20"
        netstat -tulpn | head -20
    else
        echo "Ni ss ni netstat ne sont disponibles."
    fi
    coach "Chaque port LISTEN = une porte ouverte sur ton royaume. Tu dois connaître chaque service qui écoute."
    line
}

rituel_6_etc_changes() {
    section "6) CHANGEMENTS RÉCENTS DANS /etc (<24h)"
    cmd_info "find /etc -mtime -1 2>/dev/null | head -20"
    find /etc -mtime -1 2>/dev/null | head -20
    coach "Toute modification dans /etc = configuration. Si quelque chose change sans toi, tu dois le savoir."
    line
}

rituel_7_ip() {
    section "7) INTERFACES & ADRESSES IP — ip -br a"
    if command -v ip >/dev/null 2>&1; then
        cmd_info "ip -br a"
        ip -br a
    else
        echo "Commande ip indisponible."
    fi
    coach "Observe ton IP principale, les interfaces UP, les interfaces virtuelles (Docker/VM). Un tunnel inattendu = suspicion."
    line
}

rituel_8_users() {
    section "8) UTILISATEURS DÉCLARÉS — /etc/passwd"
    cmd_info "cut -d: -f1 /etc/passwd | sort"
    cut -d: -f1 /etc/passwd | sort
    coach "Un nouveau compte système peut être légitime… ou un point d'entrée malicieux. Tu dois reconnaître les noms."
    line
}

rituel_9_sudo() {
    section "9) DROITS SUDO — sudo -l"
    cmd_info "sudo -l"
    sudo -l 2>/dev/null || echo "Impossible de lire sudo -l (pas de sudo ou pas de droits)."
    coach "Ce que tu peux faire en sudo = ton pouvoir. Un changement ici = changement dans l'équilibre des forces."
    line
}

rituel_10_reflexion() {
    section "10) CONCLUSION — QUOI DE DIFFÉRENT PAR RAPPORT À HIER ?"
    coach "Question clé : qu'est-ce qui est différent d'hier ?"
    coach "Uptime, logs, ports, IP, utilisateurs, sudo… quelque chose a-t-il changé sans que tu l'aies décidé ?"
    echo
    echo -e "${GREEN}Rituel terminé.${RESET}"
    echo -e "Tu peux maintenant lancer : ${CYAN}./architect.sh${RESET} pour le scan complet du système."
    echo
}

# ------------------ FLUX INTERACTIF -------------------------------

clear
echo -e "${BOLD}${MAGENTA}RITUEL QUOTIDIEN — LINUX ARCHITECT (MODE INTERACTIF)${RESET}"
echo
echo "Date    : $(date '+%Y-%m-%d %H:%M:%S')"
echo "Machine : $(hostname)"
echo
echo "Ce rituel se fait ÉTAPE PAR ÉTAPE."
echo "À chaque étape :"
echo "  - ENTER pour lancer le check"
echo "  - 'q' pour quitter le rituel si tu n'as plus le temps"
line

# Suite d'étapes guidées
press_to_continue
rituel_1_uptime

press_to_continue
rituel_2_topcpu

press_to_continue
rituel_3_logs

press_to_continue
rituel_4_lastb

press_to_continue
rituel_5_ports

press_to_continue
rituel_6_etc_changes

press_to_continue
rituel_7_ip

press_to_continue
rituel_8_users

press_to_continue
rituel_9_sudo

press_to_continue
rituel_10_reflexion
