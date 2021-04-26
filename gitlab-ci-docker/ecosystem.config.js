module.exports = {
  apps: [{
    name: 'gitlab-ci-docker',
    script: 'npm',
    args: 'run prod',
    output: './logs/out.log',
    error: './logs/error.log',
    time: true,
    exec_mode: 'fork', // need explicitly declare mode otherwise it will fallback to cluster mode and cause infinite reload
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }],
}
