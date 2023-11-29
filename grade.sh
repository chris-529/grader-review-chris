CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


example=`find ./student-submission -name ListExamples.java`
if ! [[(-e $example)]]
then
echo 'Missing file ListExamples.java!'
exit
fi 

#MOVE EVERYTHING WE NEED TO A GRADING AREA THAT DUPLICATES STUDENT'S SUBMISSION + TESTS
cp -r student-submission/* grading-area 
cp TestListExamples.java grading-area
cp -r lib grading-area

##step into the grading-area
cd grading-area

javac -cp $CPATH *.java
VALUE=$?
if [[ $VALUE -ne 0 ]]
    then
    echo 'Error with compiling code!'
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt

grep "Tests run:" test-output.txt > faulty.txt
grep "OK" test-output.txt > success.txt

echo 'The code you submitted was run through tests:'

faulty=`wc -c < faulty.txt`

if [[ $faulty -eq 0 ]]
then
echo 'There were no errors with your code!'
else 
echo 'There were some tests that failed:'
cat faulty.txt
fi




# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
