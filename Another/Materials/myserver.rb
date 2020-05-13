#!/usr/bin/ruby

require 'webrick'
include WEBrick

    options = {:Port => 8080, :DocumentRoot => "."}

    s = WEBrick::HTTPServer.new(options)
    HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html')
    shut = proc {s.shutdown}
    siglist = %w"TERM QUIT"
    siglist.concat(%w"HUP INT") if STDIN.tty?
    siglist &= Signal.list.keys
    siglist.each do |sig|
      Signal.trap(sig, shut)
    end
    s.start
