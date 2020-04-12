#!/usr/bin/ruby
# frozen_string_literal: true

#
# List and count all repos on a Bitbucket server, arranged by project, to STDOUT.
#
require 'json'

bb_server   = 'https://bitbucket'
bb_user     = #{bb_user}
bb_password = #{bb_password}
bb_max_repos = 1000 # Increase if you have more than 2000 repos

get_repos = "curl -s -u '#{bb_user}':'#{bb_password}' -X GET #{bb_server}/rest/api/1.0/repos"
get_users = "curl -s -u '#{bb_user}':'#{bb_password}' -X GET #{bb_server}/rest/api/1.0/users"
state_limit = "?limit='#{bb_max_repos}'"
repos_raw = JSON.parse(`#{get_repos}#{state_limit}`)
# users_raw = JSON.parse(`#{get_users}#{state_limit}`)
# puts repos_raw

projects = {}
repo_count = repos_raw['values'].count
repos_raw['values'].each do |r|
  proj_id = r['project']['key']
  if projects[proj_id].nil?
    projects[proj_id] = {}
    projects[proj_id]['name'] = r['project']['name']
    projects[proj_id]['repos'] = {}
  end
  repo_name = r['name']
  projects[proj_id]['repos'][repo_name] = r['links']['clone'][0]['href']
end

private_proj_count = projects.keys.grep(/^\~/).count
public_proj_count = projects.keys.count - private_proj_count

report_text = ''
private_repo_count = 0
projects.keys.sort.each do |p|
  # Personal project slugs always start with tilde
  is_private = p[0]
  proj_repo_count = projects[p]['repos'].keys.count
  private_repo_count += proj_repo_count if is_private
  report_text += "\nProject: #{p} : #{projects[p]['name']}\n  #{proj_repo_count} #{is_private ? 'PERSONAL' : 'Public'} repositories\n"

  projects[p]['repos'].keys.each do |r|
    report_text += format("    %-10s : %s\n", "Repository: #{r}", "URL: #{projects[p]['repos'][r]}")
  end
end

puts "BITBUCKET REPO REPORT\n\n"
puts format('  Total Projects: %5d     Public: %5d    Personal: %5d', projects.keys.count, public_proj_count, private_proj_count)
puts format('  Total Repos:    %5d     Public: %5d    Personal: %5d', repo_count, repo_count - private_repo_count, private_repo_count)
puts report_text
# puts projects
