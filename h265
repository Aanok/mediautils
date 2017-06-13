#!/bin/bash
# run as 'nohup ./h265.sh &' for background execution
# to grab all streams from the first input file, inlcuding attachments, use '-map 0'
# to grab all attachments from the first input file use '-map 0:t'
# to encode in 720p use '-s hd720'
# to encode with 10 bits of colour depth use '-pix_fmt yuv420p10'
# to strip the final dot and extension from $x use '${x%.*}'
# if you need to reencode audio use Opus: '-c:a libopus -vbr on -compression_level 10 -b:a 128000' (64kbps per channel)
# to set all audio streams to 2 channels: '-ac 2' (note this will just copy over FL and FR channels without any mixing)
# to convert 5.1 sound to stereo for all audio streams with good volume levels: '-af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR"'

# figure out a task name
shopt -s extglob
if [[ "$PWD" == */[sS]@(eason\ +([0-9])|pecial?(s))* ]]; then
	taskname="${PWD%%/[sS]@(eason\ +([0-9])|pecial?(s))*}"
	taskname="${taskname##*/}"
else
	taskname="${PWD##*/}"
fi
shopt -u extglob

# create output directory if it doesn't exist
if [ ! -d reencode ]; then mkdir reencode; fi

# do the actual work
input=*.mkv
for x in $input; do
	ffmpeg -i "$x" \
	-map 0 -s hd720 -pix_fmt yuv420p10 \
	-c:v libx265 -preset ultrafast -crf 16 \
	-c:a copy \
	-c:s copy \
	"./reencode/${x%.*}.mkv"
done

# setup start of body of mail notification
if [ -f mailbody ]; then rm mailbody; fi
echo 'Reencoding attempt of' "$taskname" 'completed.' >> mailbody
echo >> mailbody

# look, starting from scratch, that each input file has an output equivalent
successes=( )
failures=( )
for x in $input; do
if [ -f ./reencode/"${x%.*}.mkv" ]; then
		# the file was reencoded
		successes=( "${successes[@]}" "${x%.*}.mkv" )
	else
		# the file was not reencoded
		failures=( "${failures[@]}" "$x" )
	fi
done

# complete body of mail notification
if [ ${#successes[@]} = 0 ]; then
	echo 'No file was reencoded.' >> mailbody
else
	echo 'The following files were generated:' >> mailbody
	printf '%s\n' "${successes[@]}" >> mailbody
fi
echo >> mailbody

if [ ${#failuress[@]} = 0 ]; then
        echo 'All input files were processed.' >> mailbody
else
        echo 'The following files could not be processed:' >> mailbody
        printf '%s\n' "${failures[@]}" >> mailbody
fi

# send mail notification
cat mailbody | mail -s "Reencoding $taskname" fabrizio07@gmail.com

# cleanup
rm mailbody
