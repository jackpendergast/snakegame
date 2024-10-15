node('ubuntu-AppServer-3120')
{

def app
stage('Cloning Github')
{
    /*cloning the girhub repository*/
    checkout scm
}

stage('Build and Tag Image')
{
    /*build the docker image and append a tag at the end*/
    
    app = docker.build('penjack/snake_game_repo')
}

stage('Post Image to Dockerhub')
{
    /*push Image to DockerHub Repository*/
    
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials')
    {
        app.push('latest')
    }
}

stage('Deploy')
{
    sh 'docker-compose down --remove-orphans'
    sh 'docker compose up -d'
    
}
}