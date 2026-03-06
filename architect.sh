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
#     → faire de moi l’architecte total de mon système,
#       capable de lire la machine comme un livre ouvert.
#
#  Grâce à lui, j’apprends à reconnaître ce qui est normal ou
#  anormal, je développe mes réflexes systèmes, mes réflexes
#  sécurité, et ma compréhension profonde de l’environnement
#  Linux — avant même les outils offensifs comme nmap ou metasploit.
#
#  Ce script n'est pas une simple démonstration : c’est un
#  environnement d’apprentissage autonome, un système dans le
#  système, conçu pour me former chaque fois que je l’exécute,
#  jusqu’à devenir maître incontesté de Linux.
# ================================================================

# ----- Couleurs & helpers -----
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
    echo "Son objectif : faire de moi l’architecte total de mon système, capable de lire la"
    echo "machine comme un livre ouvert, avant même de toucher aux outils offensifs comme"
    echo "nmap ou metasploit."
    echo
    echo "Ce n'est pas une simple démo : c’est un environnement d’apprentissage autonome,"
    echo "un système dans le système, conçu pour me former à chaque exécution."
    echo
}

show_phase2_method() {
    echo -e "${BOLD}${CYAN}================= MODE D’EMPLOI — PHASE 2 PRATIQUE =================${RESET}"
    echo
    echo "La Phase 2 transforme ce script en terrain d’entraînement opérationnel."
    echo "Pour chaque section (processus, réseau, utilisateurs, logs, sécurité…), suis ce protocole :"
    echo
    echo "1) SCAN"
    echo "   J’observe l’état réel de la machine grâce à la section affichée."
    echo "   Je ne saute rien. Je lis calmement."
    echo
    echo "2) ANALYSE"
    echo "   Je me demande : Qu’est-ce que je vois ? Est-ce normal ? À quoi ça sert ?"
    echo "   J’identifie faits → anomalies → patterns."
    echo
    echo "3) QUESTION STRATÉGIQUE"
    echo "   Je pense comme un DEFENDER : « Est-ce cohérent ? Est-ce sécurisé ? »"
    echo "   Je pense comme un ATTACKER : « Comment j’exploiterais ça si j’étais sur cette machine ? »"
    echo
    echo "4) ACTION"
    echo "   Je corrige, j’améliore, je teste : chmod, chown, kill, systemctl, inspection de logs, etc."
    echo
    echo "5) VALIDATION"
    echo "   Je relance la commande → je vérifie que ma correction est réelle."
    echo "   Rien ne compte sauf l’état final de la machine."
    echo
    echo "Ce cycle SCAN → ANALYSE → STRATEGIE → ACTION → VALIDATION est le cœur du métier"
    echo "Admin Linux, Pentester, SOC, Red Team."
    echo
}

# =====================================================================
#  MODE CHALLENGE — PHASE 2 (exercice pratique)
# =====================================================================

CHALLENGE_LOG="$HOME/architect_challenges.log"

challenge_system() {
    local exercises=(
        "Analyse les 3 processus les plus gourmands en CPU et explique ce qu'ils font."
        "Trouve un service en état 'failed' et explique pourquoi (systemctl --failed)."
        "Identifie le processus qui consomme le plus de RAM et juge s'il est légitime."
        "Trouve un process zombie et analyse les causes possibles."
        "Liste les 10 derniers process lancés et identifie un élément suspect."
        "Analyse l’utilisation du swap et identifie l’origine de la saturation."
        "Inspecte les tâches planifiées systemd-timers et trouve une anomalie."
        "Trouve un process orphelin et explique ce que cela implique."
        "Vérifie les limites ulimit du système et identifie une mauvaise configuration."
        "Surveille l’utilisation CPU en temps réel et détecte un pic anormal."
        "Analyse les fichiers dans /run pour repérer une activité inhabituelle."
        "Liste les process ouverts par un utilisateur spécifique (ps -u username)."
        "Analyse un process ayant ouvert trop de fichiers (lsof)."
        "Repère un script cassé dans /usr/local/bin."
        "Identifie un service inutile et désactive-le proprement."
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    echo "🖥  CHALLENGE SYSTÈME :"
    echo "   ${exercises[$idx]}"
}

challenge_network() {
    local exercises=(
        "Analyse un trafic DNS live avec 'tcpdump udp port 53' et explique ce que tu observes."
        "Trouve toutes les connexions ESTABLISHED vers l'extérieur."
        "Liste les ports en LISTEN et identifie celui le plus critique d'abord."
        "Analyse les TTL dans un ping et déduis la distance réseau."
        "Liste les interfaces Docker/VM et identifie leur rôle."
        "Sniffe le trafic port 80 non-TLS et déduis l'activité."
        "Trouve les ports UDP ouverts et explique ce qu'ils signifient."
        "Analyse les ARP entries (ip neigh) et détecte une anomalie."
        "Ajoute une route manuelle, teste-la, puis supprime-la."
        "Identifie une interface réseau inactive et explique pourquoi."
        "Analyse l’utilisation d’un port exotique (ex: 31337)."
        "Trouve tous les processus liés au réseau (lsof -i)."
        "Analyse la MTU de toutes les interfaces et détecte une mauvaise config."
        "Sniffe les broadcasts locaux (tcpdump broadcast)."
        "Trouve des connexions suspectes vers le localhost."
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    echo "🌐  CHALLENGE RÉSEAU :"
    echo "   ${exercises[$idx]}"
}
challenge_soc() {
    local exercises=(
        "Analyse toutes les tentatives SSH échouées et identifie une IP suspecte."
        "Liste les dernières connexions root et vérifie si elles sont normales."
        "Analyse 10 erreurs critiques via journalctl -p err."
        "Trouve les fichiers modifiés dans /etc aujourd’hui et explique leur impact."
        "Analyse les sudoers personnalisés et commente leur sécurité."
        "Recherche les utilisateurs inactifs depuis longtemps."
        "Analyse les logs du kernel pour détecter un comportement anormal."
        "Identifie un binaire dans /usr/bin modifié récemment."
        "Trouve des fichiers contenant 'secret', 'token' ou 'key'."
        "Trouve toute connexion SSH venant de l’extérieur (journalctl _COMM=sshd)."
        "Analyse un crash de service et explique sa cause."
        "Trouve les permissions faibles dans /etc (chmod trop permissif)."
        "Analyse les logs d’authentification (auth.log)."
        "Vérifie que le fichier shadow n’a pas été lu/accédé récemment."
        "Repère un user dans /etc/passwd qui ne devrait pas exister."
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    echo "🛡  CHALLENGE SOC / BLUE TEAM :"
    echo "   ${exercises[$idx]}"
}

challenge_red() {
    local exercises=(
        "Liste tous les SUID et repère ceux dangereux."
        "Analyse les capabilities (getcap -r /) et repère une élévation possible."
        "Trouve les fichiers .ssh sur tout le système et analyse les implications."
        "Cherche des mots de passe en clair avec grep (dans ton lab)."
        "Trouve un binaire writable dans /usr/local/bin et explique son exploitation."
        "Analyse sudo -l pour trouver une commande exploitable."
        "Liste les services TCP vulnérables ou obsolètes."
        "Trouve des fichiers world-writable dans /tmp et /var/tmp."
        "Analyse les crons pour repérer ceux exploitables."
        "Vérifie l'historique root (.bash_history) si possible."
        "Identifie un script contenant une variable sensible."
        "Trouve un backup .old ou .bak contenant des secrets."
        "Analyse les services en root et trouve un candidat à exploiter."
        "Repère un binaire contenant des strings sensibles."
        "Trouve des fichiers contenant 'PRIVATE KEY'."
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    echo "🔺  CHALLENGE RED TEAM :"
    echo "   ${exercises[$idx]}"
}
challenge_forensics() {
    local exercises=(
        "Liste les fichiers exécutables dans /tmp et analyse-les."
        "Analyse les fichiers nouveaux dans /var/log."
        "Inspecte /dev/shm pour déceler une activité suspecte."
        "Trouve un process orphelin et analyse son origine."
        "Liste les fichiers cachés dans /root, /etc, /usr."
        "Analyse les libs chargées par un process (lsof -p PID)."
        "Liste les fichiers modifiés dans /usr/bin récemment."
        "Repère un fichier ayant une date de modification incohérente."
        "Trouve les scripts dans /etc/cron* et analyse celui suspect."
        "Analyse les permissions dans /var/spool."
        "Check lsmod et trouve un module inattendu."
        "Compare deux versions d’un fichier système."
        "Analyse l’activité du scheduler via pidstat."
        "Inspecte un binaire modifié (sha256sum vs backup)."
        "Trouve de l’activité dans /run ou /var/run."
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    echo "🕵  CHALLENGE FORENSICS :"
    echo "   ${exercises[$idx]}"
}
run_challenge() {
    while true; do
        clear
        echo -e "${BOLD}${MAGENTA}===== LINUX ARCHITECT — MODE CHALLENGE =====${RESET}"
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
        echo "Rappelle-toi : SCAN → ANALYSE → STRATEGIE → ACTION → VALIDATION."
        echo
        read -r -p "As-tu réussi cet exercice ? (y/n) : " RESULT
        [ -z "$RESULT" ] && RESULT="?"

        echo "[$(date '+%Y-%m-%d %H:%M:%S')] CATEGORIE=$CHOICE RESULT=$RESULT" >> "$CHALLENGE_LOG"

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
coach "Répète ce scan régulièrement et applique SCAN → ANALYSE → STRATEGIE → ACTION → VALIDATION."
echo
echo -e "${BOLD}${GREEN}🎯 LINUX ARCHITECT : SESSION TERMINÉE${RESET}"
echo
