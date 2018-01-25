
// Path where the docToolchain will produce the output files.
// This path is appended to the docDir property specified in gradle.properties
// or in the command line, and therefore must be relative to it.
outputPath = 'build'

// Path where the docToolchain will search for the input files.
// This path is appended to the docDir property specified in gradle.properties
// or in the command line, and therefore must be relative to it.
inputPath = './src'

inputFiles = [[file: 'oss.adoc', formats: ['html','pdf','docbook']]]
inputFiles = [[file: 'FrameworkOverview.adoc', formats: ['html','pdf','docbook']]]
inputFiles = [[file: 'Documentation.adoc', formats: ['html','pdf','docbook']]]
inputFiles = [[file: 'Features.adoc', formats: ['html','pdf','docbook']]]

taskInputsDirs = ["${inputPath}",
                  "${inputPath}/images",
                 ]

taskInputsFiles = ["${inputPath}/oss.adoc"]
taskInputsFiles = ["${inputPath}/FrameworkOverview.adoc"]
taskInputsFiles = ["${inputPath}/Documentation.adoc"]
taskInputsFiles = ["${inputPath}/Features.adoc"]
