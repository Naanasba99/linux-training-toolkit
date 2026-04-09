#!/usr/bin/env bash

# ================================================================
#  LINUX ARCHITECT — MISSION DU SCRIPT
#
#  Ce script est mon miroir complet : il analyse chaque couche de
#  mon système Linux — le noyau, les ressources, les disques,
#  les processus, les utilisateurs, les logs, le réseau, et les
#  changements récents. À chaque section, il me montre ce que
#  Linux voit, et un coach intégré me guide pour comprendre,
#  interpréter et maîtriser ces informations.
#
#  Son objectif est simple et absolu :
#     → faire de moi l'architecte total de mon système,
#       capable de lire la machine comme un livre ouvert.
#
#  Grâce à lui, j'apprends à reconnaître ce qui est normal ou
#  anormal, je développe mes réflexes systèmes, mes réflexes
#  sécurité, et ma compréhension profonde de l'environnement
#  Linux — avant même les outils offensifs comme nmap ou metasploit.
#
#  Ce script n'est pas une simple démonstration : c'est un
#  environnement d'apprentissage autonome, un système dans le
#  système, conçu pour me former chaque fois que je l'exécute,
#  jusqu'à devenir maître incontesté de Linux.
#
#  USAGE :
#    ./architect.sh            → mode normal (hints activés)
#    ./architect.sh --no-hint  → mode expert (commandes masquées)
# ================================================================

# ----- Flag --no-hint -----
NO_HINT=false
for arg in "$@"; do
    [ "$arg" = "--no-hint" ] && NO_HINT=true
done

# ----- Couleurs & helpers -----
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
DIM="\033[2m"
BOLD="\033[1m"
RESET="\033[0m"

section() {
    echo -e "\n${BOLD}${MAGENTA}========== $1 ==========${RESET}\n"
}

subsection() {
    echo -e "\n${BOLD}${CYAN}--- $1 ---${RESET}\n"
}

info() {
    echo -e "${GREEN}[+]${RESET} $1"
}

warn() {
    echo -e "${YELLOW}[!]${RESET} $1"
}

coach() {
    echo -e "${BLUE}Coach:${RESET} $1"
}

ask() {
    echo -e "${YELLOW}Question:${RESET} $1"
}

pause_short() {
    echo
    read -r -p "👉 Appuie sur ENTER pour continuer... " _
    echo
    clear
}

# ----- Affichage challenge : question + hint conditionnel -----
# Usage : display_challenge "EMOJI  TYPE" "question" "commande"
display_challenge() {
    local label="$1"
    local question="$2"
    local cmd="$3"

    echo "$label"
    echo "   ${question}"

    if [ "$NO_HINT" = false ]; then
        echo
        echo -e "   ${DIM}${CYAN}💡 Commande : (${cmd})${RESET}"
    fi
}

show_mission() {
    echo -e "${BOLD}${MAGENTA}"
    echo "=================================================="
    echo "          LINUX ARCHITECT — BATTLEFIELD"
    echo "=================================================="
    echo -e "${RESET}"
    echo
    echo "Ce script est mon miroir complet : il analyse chaque couche de mon système Linux —"
    echo "le noyau, les ressources, les disques, les processus, les utilisateurs, les logs,"
    echo "le réseau, et les changements récents."
    echo
    echo "Son objectif : faire de moi l'architecte total de mon système, capable de lire la"
    echo "machine comme un livre ouvert, avant même de toucher aux outils offensifs comme"
    echo "nmap ou metasploit."
    echo
    echo "Ce n'est pas une simple démo : c'est un environnement d'apprentissage autonome,"
    echo "un système dans le système, conçu pour me former à chaque exécution."
    echo

    if [ "$NO_HINT" = true ]; then
        echo -e "${YELLOW}[MODE EXPERT]${RESET} --no-hint activé. Les commandes sont masquées. Bonne chance."
    else
        echo -e "${GREEN}[MODE NORMAL]${RESET} Les commandes sont visibles. Lance avec --no-hint pour le mode expert."
    fi
    echo
}

show_phase2_method() {
    echo -e "${BOLD}${CYAN}================= MODE D'EMPLOI — PHASE 2 PRATIQUE =================${RESET}"
    echo
    echo "La Phase 2 transforme ce script en terrain d'entraînement opérationnel."
    echo "Pour chaque section (processus, réseau, utilisateurs, logs, sécurité…), suis ce protocole :"
    echo
    echo "1) SCAN"
    echo "   J'observe l'état réel de la machine grâce à la section affichée."
    echo "   Je ne saute rien. Je lis calmement."
    echo "   → Qu'est-ce que je vois ?"
    echo
    echo "2) ANALYSE"
    echo "   Je me demande : Qu'est-ce que ça signifie ? Est-ce normal ? À quoi ça sert ?"
    echo "   J'identifie faits → anomalies → patterns."
    echo "   → Qu'est-ce que ça signifie ?"
    echo
    echo "3) HYPOTHÈSE"
    echo "   Je formule une suspicion explicite AVANT d'agir."
    echo "   « Je pense que ce process est anormal parce que... »"
    echo "   « Je suspecte une élévation via ce SUID parce que... »"
    echo "   Sans hypothèse, tu réagis. Avec hypothèse, tu analyses."
    echo "   → Qu'est-ce que je suspecte et pourquoi ?"
    echo
    echo "4) STRATÉGIE"
    echo "   Je pense comme un DEFENDER : « Est-ce cohérent ? Est-ce sécurisé ? »"
    echo "   Je pense comme un ATTACKER : « Comment j'exploiterais ça ? »"
    echo "   Je choisis comment confirmer ou infirmer mon hypothèse."
    echo "   → Comment je confirme ou j'infirme ?"
    echo
    echo "5) ACTION"
    echo "   J'exécute : chmod, chown, kill, systemctl, inspection de logs, etc."
    echo "   → J'exécute."
    echo
    echo "6) VALIDATION"
    echo "   Je relance la commande → je vérifie que ma correction est réelle."
    echo "   Mon hypothèse était-elle juste ? Juste ou fausse, j'apprends."
    echo "   → Mon hypothèse était-elle correcte ?"
    echo
    echo "7) DOCUMENTATION"
    echo "   J'écris ce qui s'est passé : observation, hypothèse, action, résultat."
    echo "   Sans trace écrite, l'action n'a pas eu lieu."
    echo "   Le log architect_challenges.log est ton point de départ."
    echo "   → J'écris ce qui s'est passé."
    echo
    echo "Ce cycle SCAN → ANALYSE → HYPOTHÈSE → STRATÉGIE → ACTION → VALIDATION → DOCUMENTATION"
    echo "est le cœur du métier : Admin Linux, DFIR, SOC, Red Team."
    echo
}

# =====================================================================
#  MODE CHALLENGE — PHASE 2 (exercice pratique)
# =====================================================================

CHALLENGE_LOG="$HOME/architect_challenges.log"

challenge_system() {
    local exercises=(
        "Analyse les 3 processus les plus gourmands en CPU et explique ce qu'ils font.|ps aux --sort=-%cpu | head -4"
        "Trouve un service en état 'failed' et explique pourquoi.|systemctl --failed"
        "Identifie le processus qui consomme le plus de RAM et juge s'il est légitime.|ps aux --sort=-%mem | head -4"
        "Trouve un process zombie et analyse les causes possibles.|ps aux | awk '\$8==\"Z\" {print \$0}'"
        "Liste les 10 derniers process lancés et identifie un élément suspect.|ps aux --sort=-start_time | head -11"
        "Analyse l'utilisation du swap et identifie l'origine de la saturation.|free -h && swapon --show"
        "Inspecte les tâches planifiées systemd-timers et trouve une anomalie.|systemctl list-timers --all"
        "Trouve un process orphelin et explique ce que cela implique.|ps -eo pid,ppid,stat,cmd | awk '\$2==1 && \$3!=\"S\" {print}'"
        "Vérifie les limites ulimit du système et identifie une mauvaise configuration.|ulimit -a"
        "Surveille l'utilisation CPU en temps réel et détecte un pic anormal.|top -b -n 3 -d 1 | grep -E '^top|Cpu'"
        "Analyse les fichiers dans /run pour repérer une activité inhabituelle.|ls -lah /run | sort -k6,7"
        "Liste les process ouverts par un utilisateur spécifique.|ps -u \$(whoami) -o pid,ppid,%cpu,%mem,cmd"
        "Analyse un process ayant ouvert trop de fichiers.|lsof 2>/dev/null | awk '{print \$2}' | sort | uniq -c | sort -rn | head -5"
        "Repère un script cassé ou suspect dans /usr/local/bin.|ls -lah /usr/local/bin && file /usr/local/bin/*"
        "Identifie un service inutile et désactive-le proprement.|systemctl list-units --type=service --state=running | grep -v essential"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🖥  CHALLENGE SYSTÈME :" "$question" "$cmd"
}

challenge_network() {
    local exercises=(
        "Analyse un trafic DNS live et explique ce que tu observes.|tcpdump -i any udp port 53 -n -c 20"
        "Trouve toutes les connexions ESTABLISHED vers l'extérieur.|ss -tnp state established | grep -v 127.0.0"
        "Liste les ports en LISTEN et identifie celui le plus critique d'abord.|ss -tulpn | grep LISTEN"
        "Analyse les TTL dans un ping et déduis la distance réseau.|ping -c 5 8.8.8.8 | grep -i ttl"
        "Liste les interfaces Docker/VM et identifie leur rôle.|ip link show | grep -E 'docker|virbr|tun|veth|utun'"
        "Sniffe le trafic port 80 non-TLS et déduis l'activité.|tcpdump -i any port 80 -A -s 0 2>/dev/null | grep -E 'GET|POST|Host:|HTTP/'"
        "Trouve les ports UDP ouverts et explique ce qu'ils signifient.|ss -ulpn"
        "Analyse les ARP entries et détecte une anomalie.|ip neigh show"
        "Ajoute une route manuelle, teste-la, puis supprime-la.|ip route add 10.99.0.0/24 via \$(ip route | awk '/default/{print \$3}') && ping -c1 10.99.0.1 ; ip route del 10.99.0.0/24"
        "Identifie une interface réseau inactive et explique pourquoi.|ip link show | grep 'state DOWN'"
        "Analyse l'utilisation d'un port exotique (ex: 31337).|ss -tulpn | grep 31337 || lsof -i :31337 2>/dev/null"
        "Trouve tous les processus liés au réseau.|lsof -i -n -P 2>/dev/null | head -30"
        "Analyse la MTU de toutes les interfaces et détecte une mauvaise config.|ip link show | awk '/mtu/ && \$5 != 1500 && \$5 != 65536 {print \"⚠ ANOMALIE:\", \$2, \"MTU=\"\$5}'"
        "Sniffe les broadcasts locaux.|tcpdump -i any broadcast -n -c 20"
        "Trouve des connexions suspectes vers le localhost.|ss -tnp | grep -E '127\\.0\\.0|::1'"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🌐  CHALLENGE RÉSEAU :" "$question" "$cmd"
}

challenge_soc() {
    local exercises=(
        "Analyse toutes les tentatives SSH échouées et identifie une IP suspecte.|grep 'Failed password' /var/log/auth.log 2>/dev/null || journalctl _COMM=sshd | grep 'Failed' | tail -20"
        "Liste les dernières connexions root et vérifie si elles sont normales.|last root | head -10"
        "Analyse 10 erreurs critiques via journalctl.|journalctl -p err -n 10 --no-pager"
        "Trouve les fichiers modifiés dans /etc aujourd'hui et explique leur impact.|find /etc -mtime -1 -type f 2>/dev/null"
        "Analyse les sudoers personnalisés et commente leur sécurité.|cat /etc/sudoers && ls /etc/sudoers.d/"
        "Recherche les utilisateurs inactifs depuis longtemps.|lastlog | awk '\$NF != \"**Never\" && \$NF != \"logged\" {print}' | tail -20"
        "Analyse les logs du kernel pour détecter un comportement anormal.|dmesg | grep -iE 'error|warn|fail|oom|kill' | tail -20"
        "Identifie un binaire dans /usr/bin modifié récemment.|find /usr/bin -mtime -7 -type f 2>/dev/null"
        "Trouve des fichiers contenant 'secret', 'token' ou 'key' (dans ton home).|grep -rIl --include='*.conf,*.env,*.txt,*.sh' -E 'secret|token|api_key' ~/  2>/dev/null | head -10"
        "Trouve toute connexion SSH venant de l'extérieur.|journalctl _COMM=sshd | grep 'Accepted' | tail -20"
        "Analyse un crash de service et explique sa cause.|journalctl -p err -u \$(systemctl --failed --no-legend | awk '{print \$1; exit}') --no-pager 2>/dev/null || echo 'Aucun service en échec'"
        "Trouve les permissions faibles dans /etc (trop permissif).|find /etc -perm -o+w -type f 2>/dev/null"
        "Analyse les logs d'authentification.|tail -50 /var/log/auth.log 2>/dev/null || journalctl _COMM=sudo --no-pager | tail -20"
        "Vérifie que le fichier shadow n'a pas été accédé récemment.|stat /etc/shadow && ls -lah /etc/shadow"
        "Repère un user dans /etc/passwd qui ne devrait pas exister.|awk -F: '\$3 >= 1000 && \$7 != \"/usr/sbin/nologin\" && \$7 != \"/bin/false\" {print}' /etc/passwd"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🛡  CHALLENGE SOC / BLUE TEAM :" "$question" "$cmd"
}

challenge_red() {
    local exercises=(
        "Liste tous les SUID et repère ceux dangereux.|find / -perm -4000 -type f 2>/dev/null | sort"
        "Analyse les capabilities et repère une élévation possible.|getcap -r / 2>/dev/null"
        "Trouve les fichiers .ssh sur tout le système et analyse les implications.|find / -name 'authorized_keys' -o -name 'id_rsa' 2>/dev/null | grep -v proc"
        "Cherche des mots de passe en clair dans ton lab.|grep -rIE 'password\s*=' ~/lab/ ~/.config/ 2>/dev/null | grep -v '.git' | head -10"
        "Trouve un binaire writable dans /usr/local/bin et explique son exploitation.|find /usr/local/bin -writable -type f 2>/dev/null"
        "Analyse sudo -l pour trouver une commande exploitable.|sudo -l 2>/dev/null"
        "Liste les services TCP vulnérables ou obsolètes.|ss -tnlp | awk 'NR>1{print \$4}' | cut -d: -f2 | sort -un"
        "Trouve des fichiers world-writable dans /tmp et /var/tmp.|find /tmp /var/tmp -writable -type f 2>/dev/null"
        "Analyse les crons pour repérer ceux exploitables.|crontab -l 2>/dev/null; cat /etc/cron* /etc/cron.d/* 2>/dev/null"
        "Vérifie l'historique root si accessible.|cat /root/.bash_history 2>/dev/null || echo 'Accès refusé (normal)'"
        "Identifie un script contenant une variable sensible.|grep -rIE '(API_KEY|SECRET|PASSWORD|TOKEN)=' /usr/local/bin/ /opt/ 2>/dev/null | head -10"
        "Trouve un backup .old ou .bak contenant des secrets.|find / -name '*.bak' -o -name '*.old' -o -name '*.backup' 2>/dev/null | grep -v proc | head -10"
        "Analyse les services tournant en root.|ps aux | awk '\$1==\"root\" && \$11 !~ /^\[/' | grep -v 'ps aux'"
        "Repère un binaire contenant des strings sensibles.|strings /usr/local/bin/* 2>/dev/null | grep -iE 'password|secret|token|key' | head -10"
        "Trouve des fichiers contenant 'PRIVATE KEY'.|grep -rl 'PRIVATE KEY' / 2>/dev/null | grep -v proc | head -10"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🔺  CHALLENGE RED TEAM :" "$question" "$cmd"
}

challenge_forensics() {
    local exercises=(
        "Liste les fichiers exécutables dans /tmp et analyse-les.|find /tmp -type f -executable 2>/dev/null && ls -lah /tmp"
        "Analyse les fichiers nouveaux dans /var/log.|find /var/log -mtime -1 -type f 2>/dev/null | xargs ls -lah 2>/dev/null"
        "Inspecte /dev/shm pour déceler une activité suspecte.|ls -lah /dev/shm && find /dev/shm -type f 2>/dev/null"
        "Trouve un process orphelin et analyse son origine.|ps -eo pid,ppid,stat,cmd --no-headers | awk '\$2==1 {print}' | head -20"
        "Liste les fichiers cachés dans /root, /etc, /usr.|find /root /etc /usr -name '.*' -type f 2>/dev/null | head -20"
        "Analyse les libs chargées par un process.|lsof -p \$(ps aux --sort=-%cpu | awk 'NR==2{print \$2}') 2>/dev/null | grep -E '\\.so' | head -20"
        "Liste les fichiers modifiés dans /usr/bin récemment.|find /usr/bin -mtime -7 -type f 2>/dev/null | xargs ls -lah 2>/dev/null"
        "Repère un fichier ayant une date de modification incohérente.|find /usr/bin /usr/sbin /bin /sbin -newer /etc/passwd -type f 2>/dev/null"
        "Trouve les scripts dans /etc/cron* et analyse celui suspect.|find /etc/cron* -type f 2>/dev/null | xargs cat 2>/dev/null"
        "Analyse les permissions dans /var/spool.|ls -lah /var/spool/ && find /var/spool -perm -o+w 2>/dev/null"
        "Check lsmod et trouve un module inattendu.|lsmod | sort && lsmod | wc -l"
        "Compare deux versions d'un fichier système.|diff <(dpkg --verify 2>/dev/null) /dev/null || rpm -Va 2>/dev/null | head -20"
        "Analyse l'activité du scheduler via pidstat.|pidstat 1 3 2>/dev/null || top -b -n 1 | head -20"
        "Inspecte un binaire modifié via hash.|sha256sum /bin/bash /usr/bin/sudo 2>/dev/null"
        "Trouve de l'activité suspecte dans /run ou /var/run.|find /run /var/run -type f -newer /proc/1 2>/dev/null | head -20"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🕵  CHALLENGE FORENSICS :" "$question" "$cmd"
}

run_challenge() {
    while true; do
        clear
        echo -e "${BOLD}${MAGENTA}===== LINUX ARCHITECT — MODE CHALLENGE =====${RESET}"
        if [ "$NO_HINT" = true ]; then
            echo -e "   ${YELLOW}[MODE EXPERT — --no-hint]${RESET} Commandes masquées."
        else
            echo -e "   ${GREEN}[MODE NORMAL]${RESET} Commandes visibles. Lance avec --no-hint pour le mode expert."
        fi
        echo
        echo "Choisis une catégorie :"
        echo "  1) Système"
        echo "  2) Réseau"
        echo "  3) SOC / Blue Team"
        echo "  4) Red Team (lab, safe)"
        echo "  5) Forensics"
        echo "  0) Retour"
        echo
        read -r -p "Ton choix : " CHOICE
        echo

        case "$CHOICE" in
            1) challenge_system ;;
            2) challenge_network ;;
            3) challenge_soc ;;
            4) challenge_red ;;
            5) challenge_forensics ;;
            0) break ;;
            *) echo "Choix invalide."; sleep 1; continue ;;
        esac

        echo
        echo "Rappelle-toi : SCAN → ANALYSE → HYPOTHÈSE → STRATÉGIE → ACTION → VALIDATION → DOCUMENTATION."
        echo
        read -r -p "As-tu réussi cet exercice ? (y/n) : " RESULT
        [ -z "$RESULT" ] && RESULT="?"

        local mode_tag="NORMAL"
        [ "$NO_HINT" = true ] && mode_tag="EXPERT"

        echo "[$(date '+%Y-%m-%d %H:%M:%S')] CATEGORIE=$CHOICE MODE=$mode_tag RESULT=$RESULT" >> "$CHALLENGE_LOG"

        echo
        echo "Progression enregistrée dans : $CHALLENGE_LOG"
        echo
        read -r -p "Appuie sur ENTER pour continuer..." _
    done
}

# ======================= DEBUT DU PROGRAMME ==========================

clear
show_mission
pause_short
show_phase2_method
pause_short

echo -e "${BOLD}${CYAN}Mode d'exécution :${RESET}"
echo "  1) Scan complet (toutes les sections)"
echo "  2) Mode challenge (un exercice pratique)"
echo
read -r -p "Ton choix : " ARCH_MODE
echo

if [ "$ARCH_MODE" = "2" ]; then
    run_challenge
    exit 0
fi

# ======================= SCAN COMPLET (SECTIONS) =====================

# 1. IDENTITE DU SYSTEME
section "1. IDENTITÉ DU SYSTÈME"

subsection "Hostname, noyau, uptime"
info "Hostname :"
hostname
echo
info "Noyau et architecture :"
uname -a
echo
info "Uptime :"
uptime -p
echo
coach "Tu vois ici l'identité de la machine et depuis combien de temps elle tourne."
ask "Quelle est ta version de kernel et ton arch (x86_64, arm...) ?"
pause_short

# 2. HARDWARE & RESSOURCES
section "2. HARDWARE & RESSOURCES"

subsection "CPU"
if command -v lscpu >/dev/null 2>&1; then
    info "lscpu (résumé) :"
    lscpu | head -20
else
    warn "lscpu indisponible, fallback /proc/cpuinfo"
    grep -E 'model name|processor' /proc/cpuinfo | head
fi
ask "Combien de cœurs logiques et physiques as-tu ?"
echo
subsection "RAM & swap"
free -h
coach "Surveille la RAM et le swap. Trop de swap = système qui souffre."
ask "Est-ce que tu swappes beaucoup ?"
pause_short

# 3. STOCKAGE / FILESYSTEM
section "3. STOCKAGE / PARTITIONS / FILESYSTEM"

subsection "lsblk -f"
if command -v lsblk >/dev/null 2>&1; then
    lsblk -f
    coach "Tu vois les disques, partitions, FS et points de montage."
else
    warn "lsblk indisponible."
fi
ask "Sur quelle partition est monté ton / (root) ? Ton /home ?"
echo
subsection "df -h"
df -h
coach "Tu surveilles ici l'espace disque. Un FS à 100% = problèmes."
ask "Une partition dépasse-t-elle les 80% ?"
pause_short

# 4. PROCESSUS & SERVICES
section "4. PROCESSUS & SERVICES"

subsection "Top CPU"
ps aux --sort=-%cpu | head
coach "Le premier dans la liste est le plus gourmand en CPU."
ask "Ce process est-il normal pour ton usage actuel ?"
echo
subsection "Top mémoire"
ps aux --sort=-%mem | head
coach "Ici tu repères les gros consommateurs de RAM."
ask "Un processus consomme-t-il anormalement beaucoup ?"
echo
subsection "Services en échec"
if command -v systemctl >/dev/null 2>&1; then
    systemctl --failed
    coach "Un service en failed peut causer des bugs ou des trous de sécurité."
else
    warn "systemctl indisponible."
fi
pause_short

# 5. UTILISATEURS & SÉCURITÉ
section "5. UTILISATEURS & SÉCURITÉ"

subsection "Utilisateurs connectés"
who || echo "Aucun utilisateur connecté."
coach "Un utilisateur inconnu ici = suspicion."
echo
subsection "Dernières connexions"
if command -v last >/dev/null 2>&1; then
    last | head
else
    warn "last indisponible."
fi
echo
subsection "Capacités sudo"
sudo -l 2>/dev/null | head || echo "Impossible de lire sudo -l."
coach "Tout ce que tu peux faire en sudo = surface d'escalade potentielle."
pause_short

# 6. LOGS & SANTÉ
section "6. LOGS & SANTÉ"

subsection "Erreurs critiques (journalctl)"
if command -v journalctl >/dev/null 2>&1; then
    journalctl -p err -n 10 2>/dev/null || echo "Pas d'erreurs récentes ou accès limité."
else
    warn "journalctl indisponible."
fi
echo
subsection "Messages noyau (dmesg)"
if command -v dmesg >/dev/null 2>&1; then
    dmesg | tail -20
else
    warn "dmesg indisponible."
fi
pause_short

# 7. RÉSEAU
section "7. RÉSEAU"

subsection "Interfaces et IP"
if command -v ip >/dev/null 2>&1; then
    ip a
else
    warn "ip indisponible, fallback ifconfig"
    if command -v ifconfig >/dev/null 2>&1; then
        ifconfig
    else
        warn "Ni ip ni ifconfig."
    fi
fi
ask "Quelle est ton IP principale et ton interface de sortie ?"
echo
subsection "Table de routage"
if command -v ip >/dev/null 2>&1; then
    ip r
else
    route -n 2>/dev/null || warn "Impossible d'afficher la table de routage."
fi
coach "La route 'default' = ta passerelle vers Internet."
echo
subsection "Ports ouverts"
if command -v ss >/dev/null 2>&1; then
    ss -tulpn | head -20
elif command -v netstat >/dev/null 2>&1; then
    netstat -tulpn | head -20
else
    warn "Ni ss ni netstat disponibles."
fi
coach "Chaque port LISTEN = surface d'attaque potentielle."
pause_short

# 8. FORENSICS LÉGER
section "8. FORENSICS : CHANGEMENTS RÉCENTS"

subsection "Fichiers modifiés < 24h"
find / -mtime -1 2>/dev/null | head -20
coach "Utile en incident response pour voir ce qui a changé récemment."
ask "Reconnais-tu les chemins listés ?"
pause_short

# 9. DISTRO / PAQUETS
section "9. DISTRO & PAQUETS"

subsection "/etc/os-release"
if [ -f /etc/os-release ]; then
    cat /etc/os-release
else
    warn "/etc/os-release introuvable."
fi
echo
subsection "Paquets (aperçu)"
if command -v dpkg >/dev/null 2>&1; then
    dpkg -l | head
elif command -v rpm >/dev/null 2>&1; then
    rpm -qa | head
else
    warn "Ni dpkg ni rpm."
fi
pause_short

# 10. CONTAINERS / VIRTUALISATION
section "10. CONTAINERS & VIRTUALISATION"

subsection "Docker"
if command -v docker >/dev/null 2>&1; then
    docker ps
else
    warn "Docker non installé."
fi
echo
subsection "Hyperviseur"
grep -i hypervisor /proc/cpuinfo 2>/dev/null || echo "Pas d'indication claire d'hyperviseur."
pause_short

# 11. FIN
section "11. FIN DU SCAN — RÉCAP"

coach "Tu viens de parcourir : identité, CPU/RAM, disques, processus, utilisateurs,"
coach "logs, réseau, changements récents, paquets, containers et virtualisation."
coach "Répète ce scan régulièrement et applique SCAN → ANALYSE → HYPOTHÈSE → STRATÉGIE → ACTION → VALIDATION → DOCUMENTATION."
echo
echo -e "${BOLD}${GREEN}🎯 LINUX ARCHITECT : SESSION TERMINÉE${RESET}"
echo
