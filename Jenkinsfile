pipeline {
  agent any
  stages {
    stage('flutter check') {
      steps {
        sh 'echo $PATH'
        sh 'flutter --version'
      }
    }

  }
  environment {
    PATH = '$PATH:/opt/homebrew/bin/'
  }
}