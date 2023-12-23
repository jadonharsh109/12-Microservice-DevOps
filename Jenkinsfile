pipeline {
    agent any

    
    
    stages{

        stage('Retrieve committer email') {
            steps {
                script {
                    def committerEmail = sh(
                        returnStdout: true,
                        script: "git log -1 --pretty=format:%ae"
                    ).trim()
                    echo "Committer email: ${committerEmail}"
                }
    }
}

        stage ("Hello World") {
            steps{
                echo "Hello World From Jenkins"
            }
        }
    }

    post{
        always {

            def committerEmail = sh(script: 'git log -1 --pretty=format:%ae', returnStdout: true).trim()

            emailext (
                subject: "Pipeline Name: ${JOB_NAME}",
                body: '''<html>
                            <body>
                                <p>Build Status: <b>${BUILD_STATUS}</b></p>
                                <p>Build Status: <b>${BUILD_NUMBER}</b></p>
                                <p>Check the <i><a href="${BUILD_URL}"> console output</a></i>.</p>
                            </body>
                        </html>''',
                to: committerEmail,
                from: 'no-reply@jenkins.com',
                replyTo: 'no-reply@jenkins.com',
                mimeType: 'text/html'
            )
        }
    }
}