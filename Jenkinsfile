pipeline{

        agent none
        
            stage('Cloning Github')
            {
                agent{

                    label 'ubuntu-AppServer-3120'
                }
                steps{
                        /*cloning the girhub repository*/
                        checkout scm
                }
            }

            stage('Build and Tag Image')
            {
                agent{

                    label 'ubuntu-AppServer-3120'
                }
                steps{
                            /*build the docker image*/
                            app = docker.build('penjack/snake')
                }
            }

            stage('Post Image to Dockerhub')
            {
                agent{

                    label 'ubuntu-AppServer-3120'
                }
                steps{
                        /*push Image to DockerHub Repository and append a tag at the end*/
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials')
                        {
                            app.push('latest')
                        }
                }
            }

            stage('Deploy')
            {
                agent{

                    label 'ubuntu-AppServer-3120'
                }
                steps{
                        /*Deploy the server*/
                        sh 'docker-compose down'
                        sh 'docker compose up -d'
                }
            }
    }