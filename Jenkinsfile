pipeline {
    agent any
    
    stages{
        stage ("Hello World") {
            steps{
                echo "Hello World From Jenkins"
            }
        }
    }

    post{
        always {
            emailext (
                subject: "Pipeline Name: ${JOB_NAME}",
                body: '''<html>
                            <body>
                                <p>Build Status: <b>${BUILD_STATUS}</b></p>
                                <p>Build Status: <b>${BUILD_NUMBER}</b></p>
                                <p>Check the <a href="${BUILD_URL}"console output</a>.</p>
                            </body>
                        </html>''',
                to: 'jadonharsh109@gmail.com',
                from: 'no-reply@jenkins.com',
                replyTo: 'no-reply@jenkins.com',
                mimeType: 'text/html'
            )
        }
    }
}