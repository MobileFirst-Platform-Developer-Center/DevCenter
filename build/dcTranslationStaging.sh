# File: 		dcTranslationStaging
# Description: 	Prepares an update of the MobileFirst Development Center translation-staging site.
# Usage:		Run `. dcTranslationStaging --help` for usage instructions.
# Author:		Sharon Lifshitz (SHARONL@il.ibm.com)

# - In the event of changes to translation commitments, add the respective DC_XXX_NO_TRANS
#   no-translation-files variables, (and the complementary translation-commitment comments).
# - To add or remove a translation unit, add/remove the related DC_XXX_NO_TRANS variables,
#   and edit the local dcTranslationStaging() $dc_tsc_ids and $dc_tsc_dir_names arrays.

# MobileFirst Development Center GitHub repository
DC_GIT_REPO_NAME="DevCenter"
DC_GIT_REPO="MFPSamples/${DC_GIT_REPO_NAME}"
DC_GIT_REPO_URL="git@github.ibm.com:${DC_GIT_REPO}.git"

# MobileFirst Development Center GitHub translation branch
DC_TRANS_BRANCH="translation-staging"

# Root translation directory
DC_ROOT_TRANS_DIR="tutorials"

# Common translation directory
DC_COMMON_TRANS_DIR="foundation/8.0"

# English-sources directory
DC_EN_SRC_ROOT_DIR="${DC_ROOT_TRANS_DIR}/en"
DC_EN_SRC_TRANS_DIR="${DC_EN_SRC_ROOT_DIR}/${DC_COMMON_TRANS_DIR}"

# Common no-translation English sources that need to be copied to all locale root directories
DC_COMMON_ROOT_TRANS_DIR_NO_TRANS_FILES="index.md"
# Common no-translation English sources that need to be copied to all locale translation directories
DC_COMMON_TRANS_DIR_NO_TRANS_FILES="advanced-samples/ api/"

# Development Center translation-project (MFEPGAB) Charge-to-ID (C2ID) files
MFEPGABD001="index.md"
MFEPGABD002="all-tutorials.html"
MFEPGABD003="product-overview/"
MFEPGABD004="installation-configuration/"
MFEPGABD005="quick-start/"
MFEPGABD006="application-development/"
MFEPGABD007="adapters/"
MFEPGABD008="authentication-and-security/"
MFEPGABD009="notifications/"
MFEPGABD010="analytics/"
MFEPGABD011="bluemix/"
MFEPGABD012="administering-apps/"
MFEPGABD013="upgrading/"
MFEPGABD014="appcenter/"
#MFEPGABD015="advanced-samples/" # This C2ID was cancelled. The English version is copied to all locales via $DC_COMMON_TRANS_DIR_NO_TRANS_FILES.
MFEPGABD016="admin-tutorials.html"
MFEPGABD017="cordova-tutorials.html"
MFEPGABD018="ios-tutorials.html"
MFEPGABD019="android-tutorials.html"
MFEPGABD020="windows-8-10-tutorials.html"
MFEPGABD021="web-tutorials.html"
MFEPGABD022="server-side-tutorials.md"
MFEPGABD023="xamarin-tutorials.html"

# No-translation TSC files, to be replaced with the latest English version (in addition to the $DC_COMMON_TRANS_DIR_NO_TRANS_FILES files).
# See the TSC commitments, see https://ibm.ent.box.com/folder/17013519134.
# Brazilian Portuguese (BPO / pt-BR)
# [commitment: ${MFEPGABD001} ${MFEPGABD002} ${MFEPGABD003} ${MFEPGABD004} ${MFEPGABD005}]
DC_BPO_NO_TRANS="${MFEPGABD006} ${MFEPGABD007} ${MFEPGABD008} ${MFEPGABD009} ${MFEPGABD010} ${MFEPGABD011} ${MFEPGABD012} ${MFEPGABD013} ${MFEPGABD014} ${MFEPGABD016} ${MFEPGABD017} ${MFEPGABD018} ${MFEPGABD019} ${MFEPGABD020} ${MFEPGABD021} ${MFEPGABD022} ${MFEPGABD023}"
# Simplified Chinese (CHS / zh-Hans)
# [commitment All]
DC_CHS_NO_TRANS=""
# French (FRE / fr)
# [commitment: ${MFEPGABD001} ${MFEPGABD003} ${MFEPGABD004} ${MFEPGABD005} ${MFEPGABD012} ${MFEPGABD014} ]
DC_FRE_NO_TRANS="${MFEPGABD002} ${MFEPGABD006} ${MFEPGABD007} ${MFEPGABD008} ${MFEPGABD009} ${MFEPGABD010} ${MFEPGABD011} ${MFEPGABD013} ${MFEPGABD016} ${MFEPGABD017} ${MFEPGABD018} ${MFEPGABD019} ${MFEPGABD020} ${MFEPGABD021} ${MFEPGABD022} ${MFEPGABD023}"
# German (GER / de)
# [commitment: ${MFEPGABD001} ${MFEPGABD002} ${MFEPGABD003} ${MFEPGABD005} ${MFEPGABD007} ${MFEPGABD008} ${MFEPGABD009} ${MFEPGABD010} ${MFEPGABD011} ${MFEPGABD012} ${MFEPGABD013} ${MFEPGABD014} ${MFEPGABD016} ${MFEPGABD017} ${MFEPGABD018} ${MFEPGABD019} ${MFEPGABD020} ${MFEPGABD021} ${MFEPGABD022} ${MFEPGABD023}]
# (Originally committed to All, but then decommitted ${MFEPGABD004} and ${MFEPGABD006})
DC_GER_NO_TRANS="${MFEPGABD004} ${MFEPGABD006}"
# Japanese (JPN / ja)
# [commitment All]
DC_JPN_NO_TRANS=""
# Korean (KOR / ko)
# [commitment: ${MFEPGABD001} ${MFEPGABD002} ${MFEPGABD003} ${MFEPGABD004} ${MFEPGABD005} ${MFEPGABD006} ${MFEPGABD007} ${MFEPGABD008} ${MFEPGABD011} ${MFEPGABD012} ${MFEPGABD013} ${MFEPGABD014} ${MFEPGABD016} ${MFEPGABD017} ${MFEPGABD018} ${MFEPGABD019} ${MFEPGABD020} ${MFEPGABD021} ${MFEPGABD022} ${MFEPGABD023} ]
DC_KOR_NO_TRANS="${MFEPGABD009} ${MFEPGABD010}"
# Russian (RUS / ru)
# [commitment:  ${MFEPGABD013}]
DC_RUS_NO_TRANS="${MFEPGABD001} ${MFEPGABD002} ${MFEPGABD003} ${MFEPGABD004} ${MFEPGABD005} ${MFEPGABD006} ${MFEPGABD007} ${MFEPGABD008} ${MFEPGABD009} ${MFEPGABD010} ${MFEPGABD011} ${MFEPGABD012} ${MFEPGABD014} ${MFEPGABD016} ${MFEPGABD017} ${MFEPGABD018} ${MFEPGABD019} ${MFEPGABD020} ${MFEPGABD021} ${MFEPGABD022} ${MFEPGABD023}"
# Spanish (SPA / es)
# [commitment: ${MFEPGABD001} ${MFEPGABD003} ${MFEPGABD005} ${MFEPGABD020} ${MFEPGABD022}]
DC_SPA_NO_TRANS="${MFEPGABD002} ${MFEPGABD004} ${MFEPGABD006} ${MFEPGABD007} ${MFEPGABD008} ${MFEPGABD009} ${MFEPGABD010} ${MFEPGABD011} ${MFEPGABD012} ${MFEPGABD013} ${MFEPGABD014} ${MFEPGABD016} ${MFEPGABD017} ${MFEPGABD018} ${MFEPGABD019} ${MFEPGABD021} ${MFEPGABD023}"

# qecho: Utility function for suppressing messages in quiet mode (-q).
# USAGE: qecho [-q] [echo() options] "MESSAGE"
# -q - When set, the function does nothing. Otherwise, the function echos MESSAGE.
function qecho()
{
	if [ "-q" != "$1" ]; then
		echo "$@"
	fi
}

# dcTranslationStaging: Updates the Development Center translation staging.
# Run `. dcTranslationStaging --help` for usage instructions.
function dcTranslationStaging()
{
	local USAGE="\
NAME:        $FUNCNAME

DESCRIPTION: Prepares an update of the MobileFirst Development Center translation-staging site.
             NOTE: Run $FUNCNAME from the root directory of a ${DC_GIT_REPO} ${DC_TRANS_BRANCH} branch.

USAGE:       . dcTranslationStaging.sh [COMMANDS] [OPTIONS]

COMMANDS
  The default commands are \"merge\" and \"update\". The merge is executed before the update.
  help | --help - Display this help message. This command overrides other commands.
  merge  | m    - Merge the ${DC_GIT_REPO} master branch into the current branch.
                  By default, the merge changes are not committed automatically. See the MERGE OPTIONS.
                  Note: The merge is preceded by a git pull from the ${DC_GIT_REPO_NAME} ${DC_TRANS_BRANCH} branch,
                  and a git fetch from the ${DC_GIT_REPO_NAME} master branch.
  update | u    - Update the no-translation files in the translation directories from the English sources.

OPTIONS
  --quiet    | -q - Quiet: suppress information messages.
  --verbose  | -v - Verbose: display extra information.
MERGE OPTIONS
  The following options are applicable only to the \"merge\" command:
  --commit      - Commit the merge changes automatically. By default, the merge is done without commit (--no-commit),
                  and if the -q option is not set you are given the option to review and commit the changes.
  --edit        - Open the merge-commit message in an editor. By default, the automated merge commit message is used.

EXAMPLES
- $FUNCNAME - Merge from the master branch without committing the merge changes automatically, and then
                         update the no-translation files. You have the option to commit before the update.
- $FUNCNAME merge --commit update -q - Merge from the master branch and commit the merge changes, and then
                         update the no-translation files. Suppress information messages.
- $FUNCNAME merge --commit - Merge from the master branch and commit the merge changes 
- $FUNCNAME update -v - Update the no-translation files without merging from the master branch. Display extra information.
"

	# TSC IDs
	local -a dc_tsc_ids=( BPO CHS FRE GER JPN KOR RUS SPA )
	# GitHub TSC local directory names (= locale IDs in all lower case)
	local -a dc_tsc_dir_names=( pt-br zh-hans fr de ja ko ru es )
	# TSCs counter
	local dc_tscs_ctr=${#dc_tsc_ids[@]}

	local input=""
	local quiet=""
	local verbose=""
	local is_merge=0
	local is_no_trans_up=0

	local merge_commit="--no-commit"
	local commit_edit="--no-edit"

	local git_head="$(git symbolic-ref --short -q HEAD)"
	local git_remote=$(git config branch.$git_head.remote)
	local git_merge_head_ref=$(git config branch.$(git symbolic-ref --short -q HEAD).merge)
	local git_merge_head=${git_merge_head_ref#refs/heads/}

	# Verify that the current branch is tracking remote branch $DC_TRANS_BRANCH
	if [ "${DC_TRANS_BRANCH}" != "${git_merge_head}" ]; then
		echo "ERROR: The current branch (${git_head}) is tracking remote branch ${git_remote}/${git_merge_head}."
		echo "To run $FUNCNAME, first check out the ${DC_GIT_REPO} ${DC_TRANS_BRANCH} branch."
		return 1
	fi

	# Get commands
	while :
	do
		case $1 in
			help   | --help)	echo -e "$USAGE"; return 0 ;;
			merge  | m) 	 	let is_merge=1 ;;
			update | u) 		let is_no_trans_up=1 ;;
			*) break ;;
		esac
		shift
	done
	
	# Get options
    while :
    do
		[[ $# -eq 0 ]] && break
        case $1 in
            --quiet    | -q)	quiet="-q" ;;
            --verbose  | -v)	verbose="-v" ;;
			--commit)			merge_commit=$1 ;;
			--edit) 			commit_edit=$1 ;;
			-*) echo "ERROR: Unknown option ($1)";
			    echo -e "$USAGE";
				return 1 ;;
			 *) echo "ERROR: Unknown command ($1)";
			    echo -e "$USAGE";
				return 1 ;;
        esac
        shift
    done

	if [[ 0 -eq $is_merge && 0 -eq $is_no_trans_up ]]; then
		# Default commands - merge from the $DC_GIT_REPO master branch, and update no-translation locale files
		let is_merge=1
		let is_no_trans_up=1
	fi

	# Root-directory sanity check for the no-translation files update
	if [[ 1 -eq $is_no_trans_up && ! -d ${DC_EN_SRC_TRANS_DIR} ]]; then
		echo "ERROR: Run the script from the root directory of your cloned ${DC_GIT_REPO} repository."
		return 1
	fi

	# Merge from the $DC_GIT_REPO master branch into the local $DC_TRANS_BRANCH branch
	if [ 1 -eq $is_merge ]; then
		local out

		# Pull from the $DC_GIT_REPO $DC_TRANS_BRANCH branch into the local branch
		qecho $quiet "Pulling from the ${DC_GIT_REPO} ${DC_TRANS_BRANCH} branch ..."
		git pull $quiet $verbose ${DC_GIT_REPO_URL} ${DC_TRANS_BRANCH}

		# Fetch from the $DC_GIT_REPO master branch
		qecho $quiet "Fetching from the ${DC_GIT_REPO} master branch into local branch ${git_head} ..."
		git fetch $quiet $verbose ${DC_GIT_REPO_URL} master

		out=$(git log -p ..FETCH_HEAD)
		if [ "" == "${out}" ]; then # The local branch is up to date with the master branch -> nothing to merge
			let is_merge=0
			qecho $quiet "** Merge not required: local branch ${git_head} is already up to date with the ${DC_GIT_REPO} master branch."
		else if [ "" == "$quiet" ]; then # Merge from master is required
			read -p "Display a patched commit log of the fetched changes [y/n]? " input
			while :
			do
				case $input in
					#y | Y) 	echo "${out}";
					# Do not use $out because it discards the syntax highlighting.
					y | Y) 	git log -p ..FETCH_HEAD;
							local merge_input;
							read -p "Proceed to merge [y/n]? " merge_input;
							while :
							do
								case $merge_input in
									y | Y) break ;;
									n | N) let is_merge=0; break ;;
									*) echo "Unknown option ($merge_input)" ;;
								esac
							done
					   		break ;;
					n | N) 	break ;;
					*) echo "Unknown option ($input)" ;;
				esac
			done
		fi fi

		if [ 1 -eq $is_merge ]; then
			# Merge from .git/FETCH_HEAD = $DC_GIT_REPO master
			qecho $quiet "Merging from the ${DC_GIT_REPO} master branch into local branch ${git_head} (merge options: $merge_commit $commit_edit) ..."
			if [ "--no-commit" == "$merge_commit" ]; then # Merge without an automatic commit
				git merge $quiet $verbose $merge_commit FETCH_HEAD
				
				qecho $quiet "**TODO** Verify and commit the merge changes, or abort the merge (\`git merge --abort\`)."

				if [[ "" == "$quiet" ]]; then
					echo "1. Commit the merge changes and continue"
					echo "2. Continue without committing merge changes"
					echo "3. Abort the merge and exit"
					echo "4. Exit"
					while :
					do
						read -p "Enter selection: " input
						case $input in
							1) git commit $verbose $commit_edit ; break ;;
							2) break ;;
							3) git merge $verbose --abort; return 2 ;;
							4) return 2 ;;
							*) echo "Unknown option ($input)" ;;
						esac
					done
				fi
			else # Merge and commit
				git merge $quiet $verbose $merge_commit $commit_edit FETCH_HEAD
			fi
		fi
	fi
	
	# Update no-translation files from the English sources
	if [ 1 -eq $is_no_trans_up ]; then
		qecho $quiet "Updating no-translation files from the English sources ..."
		for (( i = 0 ; i < $dc_tscs_ctr ; i++ )); do
			# TSC ID
			local tsc_id=${dc_tsc_ids[$i]}
			# GitHub TSC local directory name (= locale ID in all lower case)
			local tsc_dir_name=${dc_tsc_dir_names[$i]}
			# GitHub TSC locale root directory
			local tsc_root_dir=${DC_ROOT_TRANS_DIR}/${tsc_dir_name}
			# GitHub TSC locale translation directory
			local tsc_trans_dir=${tsc_root_dir}/${DC_COMMON_TRANS_DIR}
			# TSC no-translation files
			local tsc_no_trans_list=DC_${tsc_id}_NO_TRANS
			tsc_no_trans_list="${DC_COMMON_TRANS_DIR_NO_TRANS_FILES} ${!tsc_no_trans_list}"

			qecho $quiet "**** ${tsc_id} (${tsc_dir_name}) ****"

			# Update root locale-directory non-translation files
			qecho $quiet "Updating ${tsc_root_dir} root-directory files from ${DC_EN_SRC_ROOT_DIR} ..."
			cp ${verbose} ${DC_EN_SRC_ROOT_DIR}/${DC_COMMON_ROOT_TRANS_DIR_NO_TRANS_FILES} ${tsc_root_dir}

			# Update $DC_COMMON_TRANS_DIR locale-directory non-translation files
			qecho $quiet "Updating ${tsc_trans_dir} no-translation files from ${DC_EN_SRC_TRANS_DIR} ..."
			for j in ${tsc_no_trans_list}; do
				[[ "-v" == "$verbose" ]] && echo "    $j"
				rm -rf ${tsc_trans_dir}/$j
				cp -af ${DC_EN_SRC_TRANS_DIR}/$j ${tsc_trans_dir}/$j
			done
		done
	fi

	qecho $quiet "**** DONE ****"
	if [[ $is_merge -eq 1 || $is_no_trans_up -eq 1 ]]; then
		qecho $quiet "TODO: Verify your changes and create a pull request to push the changes to the ${DC_GIT_REPO} master branch."
	fi

	return 0
}

# Execute the main script function
dcTranslationStaging $@

