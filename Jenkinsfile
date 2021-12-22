pipeline {
  agent any

  environment {
    
    DOCKERHUB_CREDENTIALS = credentials('dockerhub_dcc')

  }
  stages {
    stage('Git Checkout'){
        steps{
            git credentialsId: 'dcc', url: 'https://github.com/parwinder-bajwa/database-connection-checker/'
        }
    }
    stage('Build our image') {
        steps {
            dir('application') {
              sh "docker build -t parwin/dcc"
            }
        }
    }
    stage('Login DockerHub') {
    steps {
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        }
    }

    stage('Push image') {
        steps {
                sh "docker push parwin/dcc"
        }
    }
    stage('Docker Remove Image') {
      steps {
        sh "docker rmi parwin/dcc"
      }
    }
    
    stage('Deploy to Kubernetes') {
      steps {
        sh '''
          kubectl apply -f app-deployment.yaml
          kubectl apply -f app-service.yaml
          sleep 5
          kubectl get pods -n application
        '''                 
        }
    }
  }   
}
