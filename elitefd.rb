#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

# Object type indicating the absence of a corresponding scan for a sold object
UNKNOWN_TYPE = "(Unknown)"

# String used to separate fields in the type table
TABLE_SEP = " | "

if ARGV[0].nil? || ARGV[0] == "-h" || ARGV[0] == "--help"
  abort "USAGE:  ./elitefd.rb <folder containing log files>"
end

DIR   = File.expand_path(ARGV[0]).freeze
FILES = Dir.glob(File.join(DIR, "*.log")).freeze

abort "ERROR: No valid log files in directory '#{DIR}'" if FILES.empty?
puts "Scanning #{FILES.size} log files in '#{DIR}' for first discoveries."

# Fancy Ruby hash stuff!
scanned_bodies = Hash.new { |h, k| h[k] = { type: nil, discovered: false } }

FILES.each.with_index do |file, index|
  print "\rParsing log #{index + 1}/#{FILES.size}..."

  File.foreach file do |line|
    # Skip everything but data sales and scans of objects, to avoid parsing all
    # lines as JSON
    next unless line.include?("SellExplorationData") || line.include?("Scan")

    parsed = JSON.parse line
    if parsed["event"] == "Scan"
      scanned_bodies[parsed["BodyName"]][:type] = parsed["StarType"] ||
        parsed["PlanetClass"]
    elsif parsed["event"] == "SellExplorationData"
      # Each 'SellExplorationData' entry has a list of objects that were counted
      # as first discoveries
      parsed["Discovered"].each do |object|
        scanned_bodies[object][:discovered] = true
      end
    end
  end
end

puts " done."

# Summary
total = scanned_bodies.size
total_first_discoveries = scanned_bodies.count { |_, b| b[:discovered] }
r = (total_first_discoveries / total.to_f * 100).round(2).to_s + "%"

puts "\n-> Found #{total} scanned or sold bodies,"
puts "   out of which #{total_first_discoveries} are first discoveries (#{r})."

# Types
by_type = Hash.new { |h, k| h[k] = { total: 0, discoveries: 0 } }
scanned_bodies.each do |_, b|
  by_type[b[:type] || UNKNOWN_TYPE][:total] += 1
  by_type[b[:type] || UNKNOWN_TYPE][:discoveries] += 1 if b[:discovered]
end

# Find longest type name to justify the table
# type_padding = by_type.max_by { |type, _| type.length }[0].length + 1

table_fields = [" Type", "Scanned", "First", "FD %"]

# Table rows in the form [type, total, first discoveries, percentage], ordered
# by total in descending order
rows = by_type.sort_by { |_, d| -d[:total] }.map do |type, data|
  [
    " " + type, # Pad types with one space to indent it in the table
    data[:total],
    data[:discoveries],
    (data[:discoveries] / data[:total].to_f * 100).round(2).to_s + "%"
  ]
end

paddings = table_fields.map.with_index do |header, index|
  rows.map { |r| r[index].to_s.length }.max
end

table_fields = table_fields.zip(paddings).map { |f, pad| f.ljust(pad) }
paddings     = table_fields.map(&:length)

puts
puts table_fields.join TABLE_SEP
puts table_fields.map { |f|  "-" * f.length }.join("-+-")

rows.each do |r|
  puts r.zip(paddings).map { |val, pad| val.to_s.rjust(pad) }.join(TABLE_SEP)
end
