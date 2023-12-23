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
                subject: "Pipeline Satus: ${BUILD_NUMBER}",
                body: '''<html>
                            <body>
                                <p>Build Status: ${BUILD_STATUS}</p>
                                <p>Build Status: ${BUILD_NUMBER}</p>
                                <p>Check the <a href="${BUILD_URL}">console output</a>.</p>
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