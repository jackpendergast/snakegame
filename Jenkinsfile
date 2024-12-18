node('ubuntu-AppServer-3120')
{
 
stage('Cloning Git')
{
    /* Let's make sure we have the repository cloned to our workspace */
    checkout scm
}

stage('SCA-SAST-SNYK-TEST'){

    snykSecurity(
        snykInstallation:'Snyk',
        snykTokenId: 'synk_api',
        severity: 'critical'
    )

}

stage('SonarQube Analysis') {

        script {
            def scannerHome = tool 'SonarQubeScanner'
            withSonarQubeEnv('sonarqube') {
                sh "${scannerHome}/bin/sonar-scanner \
                    -Dsonar.projectKey=gameapp \
                    -Dsonar.sources=."
            }
        }
    }
}

stage('Build-and-Tag')
{
    /* This builds the actual image; 
         * This is synonymous to docker build on the command line */
    def app = docker.build('penjack/snake')
    app.tag("latest")
}
 
stage('Post-to-dockerhub')
{
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials')
    {
        app.push('latest')
    }
}

stage('Prepare Environment') {
        // Find and stop any Docker container using port 80
        sh '''
        CONTAINER_ID=$(docker ps -q --filter "publish=80")
        if [ -n "$CONTAINER_ID" ]; then
            echo "Stopping container using port 80: $CONTAINER_ID"
            docker stop $CONTAINER_ID
            docker rm $CONTAINER_ID
        else
            echo "No container using port 80."
        fi
        '''
}
 
stage('Deploy')
{
    sh "docker-compose down"
    sh "docker-compose up -d"
}
