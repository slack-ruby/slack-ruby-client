# This file was auto-generated by lib/tasks/web.rake

desc 'Get info on files uploaded to Slack, upload new files to Slack.'
command 'files' do |g|
  g.desc 'Enables a file for public/external sharing.'
  g.long_desc %( Enables a file for public/external sharing. )
  g.command 'sharedPublicURL' do |c|
    c.flag 'file', desc: 'File to share.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.files_sharedPublicURL(options))
    end
  end

  g.desc 'Revokes public/external sharing access for a file'
  g.long_desc %( Revokes public/external sharing access for a file )
  g.command 'revokePublicURL' do |c|
    c.flag 'file', desc: 'File to revoke.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.files_revokePublicURL(options))
    end
  end

  g.desc 'Gets information about a team file.'
  g.long_desc %( Gets information about a team file. )
  g.command 'info' do |c|
    c.flag 'file', desc: 'Specify a file by providing its ID.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.files_info(options))
    end
  end

  g.desc 'Lists & filters team files.'
  g.long_desc %( Lists & filters team files. )
  g.command 'list' do |c|
    c.flag 'channel', desc: 'Filter files appearing in a specific channel, indicated by its ID.'
    c.flag 'ts_from', desc: 'Filter files created after this timestamp (inclusive).'
    c.flag 'ts_to', desc: 'Filter files created before this timestamp (inclusive).'
    c.flag 'types', desc: 'Filter files by type:

all - All files
spaces - Posts
snippets - Snippets
images - Image files
gdocs - Google docs
zips - Zip files
pdfs - PDF files


You can pass multiple values in the types argument, like types=spaces,snippets.The default value is all, which does not filter the list.
.'
    c.flag 'user', desc: 'Filter files created by a single user.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.files_list(options))
    end
  end

  g.desc 'Deletes a file.'
  g.long_desc %( Deletes a file. )
  g.command 'delete' do |c|
    c.flag 'file', desc: 'ID of file to delete.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.files_delete(options))
    end
  end

  g.desc 'Uploads or creates a file.'
  g.long_desc %( Uploads or creates a file. )
  g.command 'upload' do |c|
    c.flag 'channels', desc: 'Comma-separated list of channel names or IDs where the file will be shared.'
    c.flag 'content', desc: 'File contents via a POST variable. If omitting this parameter, you must provide a file.'
    c.flag 'file', desc: 'File contents via multipart/form-data. If omitting this parameter, you must submit content.'
    c.flag 'filename', desc: 'Filename of file.'
    c.flag 'filetype', desc: 'A file type identifier.'
    c.flag 'initial_comment', desc: 'Initial comment to add to file.'
    c.flag 'title', desc: 'Title of file.'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.files_upload(options))
    end
  end
end
