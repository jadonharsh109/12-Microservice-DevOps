pipeline {
    agent any

    environment {
        K8S_CLUSTER_NAME = "microservice-cluster"
    }

    stages{

        stage('Installing Dependency') {
            steps {
                sh "chmod +7 requirements.sh && ./requirements.sh"
            }
        }

        stage('Retrieve Committer Email') {
            steps {
                script {
                    committerEmail = sh(
                        script: "git log -1 --pretty=format:%ae",
                        returnStdout: true
                    ).trim()
                    echo "Committer email: ${committerEmail}"
                }
            }
        }

        stage('OWASP Scan') {
            steps {
                dependencyCheck additionalArguments: "", odcInstallation: 'dp-check'
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
            }
        }

        stage('Trivy Scan') {
            steps {
                script{
                    repositoryUrl = sh(returnStdout: true, script: 'git config remote.origin.url').trim() 
                }
                sh "sudo trivy repo $repositoryUrl -f json -o trivy-result.json"
            }
        }

        stage("Docker Login"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]){
                    sh "echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin"
                } 
            }
        }

        // Build Dockerfiles for all microservices

        // Deploy all Docker Images to an private reg.



        stage("AWS Configure"){
                    steps{
                        withCredentials([aws(credentialsId: 'aws-cred', accessKeyVariable: 'AWS_ACCESS_KEY', secretKeyVariable: 'AWS_SECRET_KEY')]){
                            sh 'sudo aws configure set aws_access_key_id "${AWS_ACCESS_KEY}" && aws configure set aws_secret_access_key "${AWS_SECRET_KEY}" && aws configure set region "ap-south-1" && aws configure set output "json"'
                        } 
                    }
                }

        // stage('Updating Kubeconfig Files') {
        //     steps {
        //         sh "sudo aws eks update-kubeconfig --name ${K8S_CLUSTER_NAME}"
        //     }
        // }      
        
        // stage('Deploying Helms Charts') {
        //     steps {
        //         sh "sudo helm upgrade --install --force microservice-charts helm-charts"
        //     }
        // }
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