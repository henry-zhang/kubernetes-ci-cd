node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "hello-newdevops"
    registryHost = "registry-vpc.cn-huhehaote.aliyuncs.com"
    imageName = "henryops/${appName}:${tag}"
    env.BUILDIMG=imageName

    stage "Build"
    
        sh "docker build -t ${imageName} -f applications/hello-newdevops/Dockerfile applications/hello-newdevops"
    
    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"

        sh "sed 's/latest/'$tag'/g' applications/hello-newdevops/k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/hello-newdevops"
}
