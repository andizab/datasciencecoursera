This code book is created to provide information that is relevant to the
variables and summaries in the `run_analysis.R` file.

## Variables

-   ‘Subject’: the ID of the subject that underwent the experiments
-   ‘Activity’: one of the six activities that measured during the
    experiment.
-   Features: all the other 561 variables (signals) that were measured
    and collected by the accelerometer and gyroscope.

## Data Sets

-   Three types of data sets were combined and utilized for the
    calculation:
    -   ‘subject\_test.txt’, ‘subject\_train.txt’: subjects (9/30
        person) that participated in testing, subjects (11/30) that
        participated in training, respectively
    -   ‘X\_test.txt’, ‘X\_train.txt’: measured features data from
        testing and training, respectively
    -   ‘y\_test.txt’, ‘y\_train.txt’: activity labels for relevant
        features from testing and training, respectively

## Descriptive features

-   The original features were recorded by their short form, therefore
    as instructed, the features were labeled by their full term for
    descriptive purpose (by the ‘gsub’ function)

## Output Data

-   The final output is the result of the average of each varibale
    calculated based on each subject for each type of activity (group by
    ‘subject’ and ‘activity’)
-   The result is saved as ‘OutputData.txt’
