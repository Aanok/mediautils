#!/bin/bash
# enable globstar for recursive file search
shopt -s globstar

# execute actual reencoding operations
for x in ./**/*.flac; do
	ffmpeg -i "$x" -c:a libmp3lame -q:a 0 "${x%.flac}.mp3"
done

# setup start of body of mail notification
if [ -f mailbody ]; then rm mailbody; fi
echo 'Reencoding ${PWD##*/} in mp3: done.' >> mailbody

# look, starting from scratch, that each flac file has an mp3 equivalent
errors=( )
for f in ./**/*.flac; do
	if [ -f "${f%.flac}.mp3" ]; then
		# the mp3 exists, we silently remove the flac
                rm "$f"
        else
		# the mp3 doesn't exist, we log this
		errors=( "${errors[@]}" "$f" )
        fi
done

# complete body of email notification
if [ ${#errors[@]} = 0 ]; then
	echo 'Operation completed successfully.' >> mailbody
else	
	echo 'Some files were not converted to mp3:'
	printf '%s\n' "${errors[@]}" >> mailbody
fi

# send email notification
cat mailbody | mail -s 'Reencoding ${PWD##*/}' fabrizio07@gmail.com

# cleanup
rm mailbody
