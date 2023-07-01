#!/bin/bash
# Bash script to calculates the MAX, MIN, MEDIAN and MEAN of the word frequencies in the
# file the  https://www.gutenberg.org/files/58785/58785-0.txt

if [ $# -ne 1 ]
   then
       echo "Please provide a txt file url"
       echo "usage ./calculate_basic_stats.sh  url"
       #exit with error
       exit 1
fi   

echo  "############### Statistics for file  ############### "

# Q1(.5 point) write  positional parameter after echo to print its value. It is the file url used by curl command.

echo "$1"


# sort based on multiple columns
#Q2(2= 1+1 for right sorting of each columns). Write last sort command options so that first column(frequencies) is
#sorted via numerical values and
#second column is sorted by reverse alphabetical order

# In this line, we get the data from the URL, change upper characters to lower characters, gets the unique words, and then sorts then with numeric first, 
# and if the numbers are the same for two words, sorts them in reverse alphabetical
sorted_words=`curl -s $1|tr [A-Z] [a-z]|grep -oE "\w+"|sort|uniq -c|sort -k1,1n -k2,2r`
sorted_words=$(echo "$sorted_words" | iconv -f UTF-8 -t ASCII//TRANSLIT) # This one helps us get rid of words with not-valid characters, which were causing issues with the for loop
# For example, é and æ

# Here, we get the number of unique words, which we can use to compare to the last steps
total_uniq_words=`echo "$sorted_words"|wc -l`
echo "Total number of words = $total_uniq_words"

#Q3(1=.5+.5 points ) Complete the code in the following echo statements to calculate the  Min and Max frequency with respective word
#Hint:  Use sorted_words variable, head, tail and command susbtitution

min_frequency_word=$(echo "$sorted_words" | head -n 1)
max_frequency_word=$(echo "$sorted_words" | tail -n 1)

echo "Min frequency and word: $min_frequency_word"
echo "Max frequency and word: $max_frequency_word"



#Median calculation

#Q4(2=1(taking care of even number of frequencies)+1 points(right value of median)). Using sorted_words,
#write code for median frequency value calculation. Print the value of the median with an echo statement, stating
# it is a median value.
#Code must check even or odd  number of unique words. For even case median is the mean of middle two values,
#for the odd case, it is middle value in sorted items.

median_value=""
if (( total_uniq_words % 2 == 0 )); then
    median_value=$((($(echo "$sorted_words" | awk '{print $1}' | head -n $(($total_uniq_words/2 + 1)) | tail -n 1) + $(echo "$sorted_words" | awk '{print $1}' | head -n $(($total_uniq_words/2)) | tail -n 1))/2))
else
    median_value=$(echo "$sorted_words" | awk '{print $1}' | head -n $(($total_uniq_words/2 + 1)) | tail -n 1)
fi

echo "Median frequency value: $median_value"



# Mean value calculation
#Q5(1 point) Using for loop, write code to update count variable: total number of unique words
#Q6(1 point) Using for loop, write code to update total_freq variable : sum of frequencies

total_freq=0
count=0

# I had to create an array in order to get the whole line, as the iterator in the for loop was getting word by word, which caused issues
readarray -t lines <<< "$sorted_words"

# Iterate over the array using a for loop
for my_line in "${lines[@]}"; do
    freq=$(echo "$my_line" | awk '{print $1}')
    count=$((count + 1))
    total_freq=$((total_freq + freq))
done

#Q7(1 point) Write code to calculate mean frequency value based on total_freq and count
mean=$((total_freq/count))

echo "Sum of frequencies = $total_freq"
echo "Total unique words = $count"
echo "Mean frequency using integer arithmetics = $mean"

#Q8(1 point) Using bc -l command, calculate mean value.
# Write your code after = 
mean_decimal=$(echo "scale=2; $total_freq/$count" | bc -l)
echo "Mean frequency using floating point arithmetics = $mean_decimal"


# Q9 (1 point) Complete lazy_commit bash function(look for how to write bash functions) to add, commit and push to the remote master.
# In the command prompt, this function is used as
#
# lazygit file_1 file_2 ... file_n commit_message
#
# This bash function must take files name and commit message as positional parameters
# and perform followling git function
#
# git add file_1 file_2 .. file_n
# git commit -m commit_message
# git push origin master

#
# Side: In the Linux if we put this function in .bashrc hidden file in
# the user home directory(type cd ~ to go to the home directory) and source .bashrc after adding this function,
# lazy_commit should be available in the command prompt.
# One can type lazy_commit file1 file2 ... filen  commit_message
# and file will be added , commited and pushed to remote master using one lazy_commit command.
function lazy_commit() {
    files="${@:1:$(($#-1))}"
    commit_message="${@: -1}"
    
    git add $files
    git commit -m "$commit_message"
    git push origin master
}
