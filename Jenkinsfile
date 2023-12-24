pipeline {
    agent {
        label "My-Linux"
    }

    stages{

        stage('Installing Dependency') {
            steps {
                sh '''sudo snap install trivy
                sudo snap install docker
                USER=$(whoami)
                sudo addgroup --system docker
                sudo adduser $USER docker
                newgrp docker
                sudo snap disable docker
                sudo snap enable docker
                '''
            }
        }

        stage('Retrieve committer email') {
            steps {
                script {
                    // Execute the Git command as a step
                    committerEmail = sh(
                        script: "git log -1 --pretty=format:%ae",
                        returnStdout: true
                    ).trim()
                    // Print the retrieved email
                    echo "Committer email: ${committerEmail}"
                }
            }
        }

        stage('OWASP Dependency-Check Vulnerabilities') {
            steps {
                dependencyCheck additionalArguments: "", odcInstallation: 'dp-check'
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
            }
    }

        // Build Dockerfiles for all microservices

        // Deploy all Docker Images to an private reg.

        // 
    }

    post{
        always {
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