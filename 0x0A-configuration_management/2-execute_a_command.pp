# Kill process killmenow

exec { 'kill_process_killmenow':
  command  => 'pkill killmenow',
  provider => 'shell',
  onlyif   => 'pgrep killmenow',
}
