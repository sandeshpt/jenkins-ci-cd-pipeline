pipeline {
  agent any

  environment {
    APP_NAME = 'devops-demo-app'
    IMAGE_REPO = 'docker.io/your-dockerhub-user/devops-demo-app'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
    KUBE_NAMESPACE = 'devops-demo'
    DEPLOYMENT_NAME = 'webapp-webapp'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Validate') {
      steps {
        sh 'bash scripts/validate.sh'
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t ${IMAGE_REPO}:${IMAGE_TAG} ./app'
      }
    }

    stage('Push Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push ${IMAGE_REPO}:${IMAGE_TAG}
          '''
        }
      }
    }

    stage('Deploy To Kubernetes') {
      steps {
        withCredentials([file(credentialsId: 'kubeconfig-dev', variable: 'KUBECONFIG')]) {
          sh '''
            kubectl set image deployment/${DEPLOYMENT_NAME} webapp=${IMAGE_REPO}:${IMAGE_TAG} -n ${KUBE_NAMESPACE}
            kubectl rollout status deployment/${DEPLOYMENT_NAME} -n ${KUBE_NAMESPACE} --timeout=120s
          '''
        }
      }
    }
  }

  post {
    failure {
      echo 'Pipeline failed. Check logs, image build, registry credentials, or Kubernetes rollout status.'
    }
    success {
      echo 'Pipeline completed successfully.'
    }
  }
}
