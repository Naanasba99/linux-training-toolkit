#!/usr/bin/env bash

# ================================================================
#  LINUX ARCHITECT — MAC EDITION
#
#  Ce script est le miroir complet de ta machine macOS : il
#  analyse chaque couche — le noyau Darwin, les ressources,
#  les disques, les processus, les services, les utilisateurs,
#  les logs, le réseau, et les changements récents.
#
#  Son objectif est identique à la version Linux :
#     → faire de moi l'architecte total de mon système,
#       capable de lire la machine comme un livre ouvert.
#
#  Adapté pour Apple Silicon (M1/M2/M3/M4) et macOS Ventura+.
#  Les commandes Linux absentes sont remplacées par leurs
#  équivalents Darwin natifs ou Homebrew.
#
#  USAGE :
#    ./architect_mac.sh            → mode normal (hints activés)
#    ./architect_mac.sh --no-hint  → mode expert (commandes masquées)
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
    echo "     LINUX ARCHITECT — MAC EDITION BATTLEFIELD"
    echo "=================================================="
    echo -e "${RESET}"
    echo
    echo "Ce script est le miroir complet de ton macOS — noyau Darwin, ressources,"
    echo "processus, services launchd, réseau, logs système, et changements récents."
    echo
    echo "Son objectif : faire de toi l'architecte total de ta machine Apple,"
    echo "capable de lire le système comme un livre ouvert."
    echo
    echo "Adapté Apple Silicon (M1/M2/M3/M4) — commandes Darwin natives."
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
    echo "   « Je suspecte une élévation via ce daemon parce que... »"
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
    echo "   J'exécute : chmod, kill, launchctl, log show, lsof, tcpdump, etc."
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
    echo "est le cœur du métier : Admin Système, DFIR, SOC, Red Team."
    echo
}

# =====================================================================
#  MODE CHALLENGE — PHASE 2 (exercice pratique)
# =====================================================================

CHALLENGE_LOG="$HOME/architect_challenges_mac.log"

challenge_system() {
    local exercises=(
        "Analyse les 3 processus les plus gourmands en CPU et explique ce qu'ils font.|ps aux -r | head -4"
        "Identifie le processus qui consomme le plus de RAM et juge s'il est légitime.|ps aux -m | head -4"
        "Surveille l'activité CPU en temps réel et détecte un pic anormal.|top -l 3 -s 1 | grep -E 'CPU|Load'"
        "Analyse l'utilisation mémoire macOS et calcule la RAM réellement disponible.|vm_stat | head -15"
        "Liste tous les daemons launchd actifs et identifie un élément suspect.|launchctl list | grep -v '^-' | head -30"
        "Trouve un daemon launchd en erreur et explique pourquoi.|launchctl list | awk '\$2 != 0 && \$2 != \"-\" {print}'"
        "Analyse les tâches planifiées (launchd agents) dans les Library.|ls ~/Library/LaunchAgents/ && ls /Library/LaunchAgents/ 2>/dev/null"
        "Vérifie les limites système et identifie une mauvaise configuration.|launchctl limit"
        "Analyse les fichiers ouverts par un processus spécifique.|lsof -p \$(ps aux -r | awk 'NR==2{print \$2}')"
        "Surveille l'activité disque en temps réel et détecte un accès suspect.|sudo fs_usage -f filesys | head -30"
        "Analyse les syscalls d'un processus en cours.|sudo dtruss -p \$(ps aux -r | awk 'NR==2{print \$2}') 2>&1 | head -20"
        "Liste les extensions kernel chargées et repère un module inattendu.|kmutil list 2>/dev/null || kextstat | grep -v com.apple"
        "Identifie un service inutile et désactive-le proprement via launchctl.|launchctl list | grep -v com.apple | grep -v org.apache"
        "Analyse l'état de System Integrity Protection et ses implications.|csrutil status"
        "Vérifie le statut FileVault et ses implications sécurité.|fdesetup status"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🖥  CHALLENGE SYSTÈME :" "$question" "$cmd"
}

challenge_network() {
    local exercises=(
        "Analyse un trafic DNS live et explique ce que tu observes.|sudo tcpdump -i en0 udp port 53 -n -c 20"
        "Trouve toutes les connexions ESTABLISHED vers l'extérieur.|netstat -anp tcp | grep ESTABLISHED | grep -v 127.0.0"
        "Liste les ports en LISTEN et identifie celui le plus critique.|lsof -i -nP | grep LISTEN"
        "Analyse les TTL dans un ping et déduis la distance réseau.|ping -c 5 8.8.8.8 | grep -i ttl"
        "Identifie toutes les interfaces réseau actives et leur rôle.|ifconfig | grep -E '^[a-z]|inet '"
        "Sniffe le trafic port 80 non-TLS et déduis l'activité.|sudo tcpdump -i en0 port 80 -A -s 0 2>/dev/null | grep -E 'GET|POST|Host:|HTTP/'"
        "Trouve les ports UDP ouverts et explique ce qu'ils signifient.|lsof -i udp -nP | grep -v ESTABLISHED"
        "Analyse le cache ARP et détecte une anomalie.|arp -a"
        "Affiche la table de routage et identifie la route par défaut.|netstat -rn | grep -E 'default|Destination'"
        "Identifie une interface réseau inactive et explique pourquoi.|ifconfig | grep -A1 'status: inactive'"
        "Trouve tous les processus utilisant le réseau en ce moment.|lsof -i -nP | head -30"
        "Analyse la MTU de toutes les interfaces et détecte une mauvaise config.|ifconfig | grep mtu | awk '\$NF != 1500 && \$NF != 16384 {print \"⚠ ANOMALIE:\", \$0}'"
        "Sniffe les broadcasts locaux.|sudo tcpdump -i en0 broadcast -n -c 20"
        "Teste la qualité réseau et analyse les résultats.|networkQuality -v 2>/dev/null || ping -c 10 8.8.8.8 | tail -3"
        "Identifie le processus qui utilise le plus de bande passante.|nettop -n -l 3 2>/dev/null | head -20"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🌐  CHALLENGE RÉSEAU :" "$question" "$cmd"
}

challenge_soc() {
    local exercises=(
        "Analyse toutes les tentatives SSH échouées et identifie une IP suspecte.|log show --predicate 'process == \"sshd\" AND message CONTAINS \"Failed\"' --last 1h 2>/dev/null | tail -20"
        "Liste les dernières connexions et vérifie si elles sont normales.|last | head -15"
        "Analyse les erreurs critiques des dernières 24h.|log show --predicate 'messageType == 16' --last 24h 2>/dev/null | tail -20"
        "Trouve les fichiers modifiés dans /etc aujourd'hui et explique leur impact.|find /etc -mtime -1 -type f 2>/dev/null"
        "Analyse les sudoers et commente leur sécurité.|sudo cat /etc/sudoers 2>/dev/null | grep -v '^#' | grep -v '^$'"
        "Recherche les utilisateurs inactifs depuis longtemps.|last | awk '{print \$1}' | sort | uniq -c | sort -rn | tail -10"
        "Analyse les logs de sécurité macOS pour détecter un comportement anormal.|log show --predicate 'subsystem == \"com.apple.security\"' --last 1h 2>/dev/null | tail -20"
        "Identifie un binaire dans /usr/local/bin modifié récemment.|find /usr/local/bin -mtime -7 -type f 2>/dev/null | xargs ls -lah 2>/dev/null"
        "Trouve des fichiers contenant 'secret', 'token' ou 'key' dans ton home.|grep -rIl -E 'secret|token|api_key' ~/  --include='*.conf' --include='*.env' --include='*.sh' 2>/dev/null | head -10"
        "Analyse les connexions SSH entrantes acceptées.|log show --predicate 'process == \"sshd\" AND message CONTAINS \"Accepted\"' --last 24h 2>/dev/null | tail -10"
        "Vérifie l'état de Gatekeeper et ses implications.|spctl --status && spctl --list 2>/dev/null | head -10"
        "Trouve les permissions faibles dans /etc.|find /etc -perm -o+w -type f 2>/dev/null | head -10"
        "Analyse les logs d'authentification récents.|log show --predicate 'process == \"SecurityAgent\" OR process == \"loginwindow\"' --last 2h 2>/dev/null | tail -20"
        "Vérifie que le fichier shadow macOS n'a pas été accédé récemment.|ls -lah /var/db/dslocal/nodes/Default/users/ 2>/dev/null | head -10"
        "Repère un utilisateur dans le système qui ne devrait pas exister.|dscl . -list /Users | grep -v '^_' | grep -v 'daemon\|nobody\|root'"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🛡  CHALLENGE SOC / BLUE TEAM :" "$question" "$cmd"
}

challenge_red() {
    local exercises=(
        "Liste tous les binaires SUID et repère ceux dangereux.|find / -perm -4000 -type f 2>/dev/null | grep -v '/System/Library'"
        "Analyse les LaunchAgents tiers installés et leur légitimité.|ls -lah ~/Library/LaunchAgents/ /Library/LaunchAgents/ /Library/LaunchDaemons/ 2>/dev/null"
        "Trouve les fichiers .ssh sur tout le système et analyse les implications.|find / -name 'authorized_keys' -o -name 'id_rsa' 2>/dev/null | grep -v proc | head -10"
        "Cherche des mots de passe en clair dans ton home et tes configs.|grep -rIE 'password\s*=' ~/lab/ ~/.config/ 2>/dev/null | grep -v '.git' | head -10"
        "Trouve un binaire writable dans /usr/local/bin et explique son exploitation.|find /usr/local/bin -writable -type f 2>/dev/null"
        "Analyse sudo -l pour trouver une commande exploitable.|sudo -l 2>/dev/null"
        "Analyse les apps qui ont accès à la caméra ou au micro.|tccutil list Camera 2>/dev/null; tccutil list Microphone 2>/dev/null"
        "Trouve des fichiers world-writable dans /tmp et /var/tmp.|find /tmp /var/tmp -writable -type f 2>/dev/null"
        "Analyse les crons utilisateur et système pour repérer ceux exploitables.|crontab -l 2>/dev/null; ls /etc/periodic/ && ls /etc/cron.d/ 2>/dev/null"
        "Vérifie l'historique shell si accessible (bash ou zsh).|cat ~/.zsh_history 2>/dev/null | tail -30 || cat ~/.bash_history 2>/dev/null | tail -30"
        "Identifie un script contenant une variable sensible dans tes outils.|grep -rIE '(API_KEY|SECRET|PASSWORD|TOKEN)=' ~/BASHSCRIPTS/ 2>/dev/null | head -10"
        "Trouve des backups .old ou .bak contenant potentiellement des secrets.|find ~ -name '*.bak' -o -name '*.old' -o -name '*.backup' 2>/dev/null | head -10"
        "Analyse les processus tournant avec des privilèges élevés.|ps aux | awk '\$1==\"root\" && \$11 !~ /^\[/' | grep -v 'ps aux' | head -10"
        "Trouve des strings sensibles dans les binaires de /usr/local/bin.|strings /usr/local/bin/* 2>/dev/null | grep -iE 'password|secret|token|key' | head -10"
        "Analyse les apps ayant accès au trousseau (Keychain).|security list-keychains && security dump-keychain -d login.keychain 2>/dev/null | grep -i 'acct\|svce' | head -20"
    )
    local idx=$((RANDOM % ${#exercises[@]}))
    local entry="${exercises[$idx]}"
    local question="${entry%%|*}"
    local cmd="${entry##*|}"
    display_challenge "🔺  CHALLENGE RED TEAM :" "$question" "$cmd"
}

challenge_forensics() {
    local exercises=(
        "Liste les fichiers exécutables dans /tmp et analyse-les.|find /tmp -type f -perm +111 2>/dev/null && ls -lah /tmp"
        "Analyse les fichiers nouveaux dans /var/log.|find /var/log -mtime -1 -type f 2>/dev/null | xargs ls -lah 2>/dev/null | head -20"
        "Inspecte /dev/shm et les zones mémoire partagée pour activité suspecte.|ls -lah /dev/shm 2>/dev/null || ls -lah /tmp/.* 2>/dev/null | head -10"
        "Trouve un processus orphelin et analyse son origine.|ps -eo pid,ppid,stat,comm | awk '\$2==1 && \$1 > 100 {print}' | head -20"
        "Liste les fichiers cachés dans les répertoires système critiques.|find /etc /usr/local /var -name '.*' -type f 2>/dev/null | head -20"
        "Analyse les dynamic libraries chargées par un processus.|vmmap \$(ps aux -r | awk 'NR==2{print \$2}') 2>/dev/null | grep '.dylib' | head -20"
        "Liste les fichiers modifiés dans /usr/local/bin récemment.|find /usr/local/bin -mtime -7 -type f 2>/dev/null | xargs ls -lah 2>/dev/null"
        "Repère un fichier ayant une date de modification incohérente.|find /usr/bin /usr/sbin /bin /sbin -newer /etc/passwd -type f 2>/dev/null | head -10"
        "Analyse les logs système pour trouver un crash récent.|log show --predicate 'messageType == 16 OR message CONTAINS \"crash\"' --last 24h 2>/dev/null | tail -20"
        "Analyse les permissions dans /var/spool.|ls -lah /var/spool/ && find /var/spool -perm -o+w 2>/dev/null"
        "Vérifie l'intégrité des binaires système.|codesign -v /bin/bash 2>&1 && codesign -v /usr/bin/sudo 2>&1"
        "Analyse les quarantaine flags des fichiers téléchargés.|find ~/Downloads -xattr -print0 2>/dev/null | xargs -0 xattr -l 2>/dev/null | grep quarantine | head -10"
        "Analyse l'activité du scheduler et des processus via Activity Monitor CLI.|ps -arcwwwxo 'pid,ppid,%cpu,%mem,command' | head -15"
        "Calcule le hash SHA256 des binaires critiques pour détecter une modification.|shasum -a 256 /bin/bash /usr/bin/sudo /usr/bin/python3 2>/dev/null"
        "Trouve de l'activité suspecte dans les logs réseau récents.|log show --predicate 'subsystem == \"com.apple.network\"' --last 30m 2>/dev/null | tail -20"
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
        echo -e "${BOLD}${MAGENTA}===== LINUX ARCHITECT — MAC EDITION — MODE CHALLENGE =====${RESET}"
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

subsection "Hostname, noyau, version macOS"
info "Hostname :"
hostname
echo
info "Noyau Darwin et architecture :"
uname -a
echo
info "Version macOS :"
sw_vers
echo
info "Uptime :"
uptime
echo
coach "Tu vois ici l'identité Darwin de ta machine et sa version exacte de macOS."
ask "Quelle est ta version de macOS et ton architecture (arm64 = Apple Silicon) ?"
pause_short

# 2. HARDWARE & RESSOURCES
section "2. HARDWARE & RESSOURCES"

subsection "CPU — Apple Silicon"
info "Puce et architecture :"
sysctl -n machdep.cpu.brand_string 2>/dev/null || system_profiler SPHardwareDataType | grep -E 'Chip|Processor'
echo
info "Cœurs logiques :"
sysctl -n hw.logicalcpu
echo
info "Cœurs physiques :"
sysctl -n hw.physicalcpu
echo
ask "Combien de cœurs Performance vs Efficiency a ton Apple Silicon ?"
echo

subsection "RAM"
info "Mémoire totale :"
sysctl -n hw.memsize | awk '{printf "%.0f GB\n", $1/1024/1024/1024}'
echo
info "Statistiques mémoire (vm_stat) :"
vm_stat | head -10
coach "Sur macOS, 'free -h' n'existe pas. vm_stat est l'équivalent natif."
coach "Pages free × 16384 = RAM libre en bytes. Divise par 1073741824 pour des GB."
ask "Combien de RAM est réellement disponible sur ta machine ?"
pause_short

# 3. STOCKAGE / FILESYSTEM
section "3. STOCKAGE / PARTITIONS / FILESYSTEM"

subsection "diskutil list"
diskutil list
coach "Équivalent macOS de lsblk. Tu vois tous les disques, partitions APFS et volumes."
ask "Sur quel volume est installé ton macOS ? Quel est son type de filesystem ?"
echo

subsection "df -h"
df -h | grep -v '/System/Volumes/VM'
coach "Surveille l'espace disque. Un volume à 90%+ = problèmes imminents."
ask "Une partition dépasse-t-elle les 80% ?"
pause_short

# 4. PROCESSUS & SERVICES
section "4. PROCESSUS & SERVICES"

subsection "Top CPU"
ps aux -r | head -11
coach "Le premier dans la liste est le plus gourmand en CPU en ce moment."
ask "Ce processus est-il normal pour ton usage actuel ?"
echo

subsection "Top mémoire"
ps aux -m | head -11
coach "Ici tu repères les gros consommateurs de RAM."
ask "Un processus consomme-t-il anormalement beaucoup de mémoire ?"
echo

subsection "Services launchd actifs"
launchctl list | grep -v '^-' | grep -v 'com.apple' | head -20
coach "Équivalent macOS de systemctl. Les services non-Apple ici méritent attention."
coach "Un PID à 0 et code de sortie non-nul = service en erreur."
ask "Y a-t-il des services tiers inattendus dans cette liste ?"
pause_short

# 5. UTILISATEURS & SÉCURITÉ
section "5. UTILISATEURS & SÉCURITÉ"

subsection "Utilisateurs connectés"
who || echo "Impossible de récupérer les sessions actives."
coach "Un utilisateur inconnu ici = suspicion immédiate."
echo

subsection "Dernières connexions"
last | head -15
echo

subsection "Capacités sudo"
sudo -l 2>/dev/null | head -15 || echo "Impossible de lire sudo -l."
coach "Tout ce que tu peux faire en sudo = surface d'escalade potentielle."
echo

subsection "Sécurité système"
info "Gatekeeper :"
spctl --status 2>/dev/null
echo
info "System Integrity Protection :"
csrutil status 2>/dev/null
echo
info "FileVault :"
fdesetup status 2>/dev/null
coach "Ces trois éléments définissent la posture de sécurité macOS de base."
pause_short

# 6. LOGS & SANTÉ
section "6. LOGS & SANTÉ"

subsection "Erreurs critiques (log show)"
log show --predicate 'messageType == 16' --last 1h 2>/dev/null | tail -15 || \
    echo "Accès limité aux logs ou aucune erreur récente."
coach "Équivalent macOS de journalctl -p err. messageType 16 = erreurs critiques."
echo

subsection "Logs kernel récents"
log show --predicate 'process == "kernel"' --last 10m 2>/dev/null | tail -15 || \
    dmesg 2>/dev/null | tail -20 || echo "Accès limité aux logs kernel."
coach "Sur macOS, dmesg est limité — log show est plus complet."
pause_short

# 7. RÉSEAU
section "7. RÉSEAU"

subsection "Interfaces et IP"
ifconfig | grep -E '^[a-z]|inet |status'
ask "Quelle est ton interface principale (en0 = Ethernet/WiFi) et ton IP ?"
echo

subsection "Table de routage"
netstat -rn | grep -E 'default|Destination' | head -10
coach "La ligne 'default' = ta passerelle vers Internet."
echo

subsection "Ports ouverts"
lsof -i -nP | grep LISTEN | head -20
coach "Chaque port LISTEN = surface d'attaque potentielle."
coach "Équivalent macOS de ss -tulpn."
pause_short

# 8. FORENSICS LÉGER
section "8. FORENSICS : CHANGEMENTS RÉCENTS"

subsection "Fichiers modifiés < 24h (zones critiques)"
find /etc /usr/local /Library/LaunchDaemons -mtime -1 2>/dev/null | head -20
coach "Utile en incident response pour voir ce qui a changé récemment."
ask "Reconnais-tu les chemins listés ? Quelque chose d'inattendu ?"
echo

subsection "Quarantaine — fichiers téléchargés récemment"
find ~/Downloads -mtime -7 -type f 2>/dev/null | head -10
coach "macOS tague les fichiers téléchargés avec un attribut de quarantaine."
coach "Commande utile : xattr -l <fichier> pour voir les attributs étendus."
pause_short

# 9. DISTRO / PAQUETS
section "9. SYSTÈME & PAQUETS"

subsection "Infos système complètes"
system_profiler SPSoftwareDataType 2>/dev/null | head -15
echo

subsection "Homebrew (aperçu)"
if command -v brew >/dev/null 2>&1; then
    info "Paquets installés via Homebrew :"
    brew list | head -20
    echo
    info "Paquets outdated :"
    brew outdated 2>/dev/null | head -10 || echo "Tout est à jour."
else
    warn "Homebrew non installé."
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

subsection "Machines virtuelles UTM / Parallels"
if command -v utmctl >/dev/null 2>&1; then
    utmctl list 2>/dev/null
else
    info "UTM CLI non disponible — vérifie via l'app UTM."
fi
echo

subsection "Rosetta (émulation x86)"
arch -x86_64 uname -m 2>/dev/null && echo "Rosetta actif" || echo "Rosetta absent ou non utilisé."
coach "Sur Apple Silicon, Rosetta traduit les binaires x86_64. Normal sur un dev Mac."
pause_short

# 11. FIN
section "11. FIN DU SCAN — RÉCAP"

coach "Tu viens de parcourir : identité Darwin, CPU/RAM Apple Silicon, disques APFS,"
coach "processus, services launchd, utilisateurs, sécurité macOS (SIP/Gatekeeper/FileVault),"
coach "logs système, réseau, changements récents, Homebrew, containers et virtualisation."
coach "Répète ce scan régulièrement et applique :"
coach "SCAN → ANALYSE → HYPOTHÈSE → STRATÉGIE → ACTION → VALIDATION → DOCUMENTATION."
echo
echo -e "${BOLD}${GREEN}🎯 LINUX ARCHITECT — MAC EDITION : SESSION TERMINÉE${RESET}"
echo
