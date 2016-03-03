require 'csv'
require 'optparse'

class CSVParser

  def self.initialize

    options = {}
    required_options = [:file, :type]

    optparse = OptionParser.new do|opts|
      opts.banner = "Usage: CSVParser.rb [options]"
      opts.on('-f', '--file FILE', '[file] Specify input file name before executing script') do |file|
        options[:file] = file;
      end

      opts.on('-t', '--tobii', '[type] Sets Tobii format as input csv') do
        options[:type] = 'tobii';
      end

      opts.on('-u', '--uxr', '[type] Sets UXR format as input csv') do
        options[:type] = 'uxr';
      end

      opts.on('-h', '--help', 'Displays Help') do
        puts opts
        exit
      end
    end

    begin
      optparse.parse!

      missing_options = required_options.select{ |opt| options[opt].nil? }
      unless missing_options.empty?
        puts "Missing options: #{missing_options.join(', ')}"
        puts optparse
        exit
      end
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument
      puts $!.to_s
      puts optparse
      exit
    end

    puts options
  end

  def self.parse
    puts ARGV
    # data = CSV.read(file, { headers: true, header_converters: :symbol, converters: :all, :col_sep => ";"})
    # hashed_data = data.map do |row|
    #   puts row.size
    #   puts row.to_hash
    #   remove_columns(row.to_hash, row.size)
    # end
    # puts hashed_data
  end

  def self.remove_columns(row, size)
    case size
      when 32
        return {:timestamp => row[:timestamp],
                :leftGazePoint2DX => row[:leftgazepoint2dx],
                :leftGazePoint2DY => row[:leftgazepoint2dy],
                :rightGazePoint2DX => row[:rightgazepoint2dx],
                :rightGazePoint2DY => row[:rightgazepoint2dy],
                :leftPupilSize => row[:leftpupilsize],
                :leftValidity => row[:leftvalidity],
                :rightPupilSize => row[:rightpupilsize],
                :rightValidity => row[:rightvalidity]}
      # else
      #   return {:timestamp => row[:localtimestamp],
      #           :leftGazePoint2DX => row[:leftgazepoint2dx],
      #           :leftGazePoint2DY => row[:leftgazepoint2dy],
      #           :rightGazePoint2DX => row[:rightgazepoint2dx],
      #           :rightGazePoint2DY => row[:rightgazepoint2dy],
      #           :leftPupilSize => row[:leftpupilsize],
      #           :leftValidity => row[:leftvalidity],
      #           :rightPupilSize => row[:rightpupilsize],
      #           :rightValidity => row[:rightvalidity]}
    end
  end


  initialize
  # parse
  # parse('./data/data_TOBII.tsv')


end