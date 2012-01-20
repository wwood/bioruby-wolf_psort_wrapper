require 'bio'

module Bio
  class PSORT
    class WoLF_PSORT
      class Wrapper
        ORGANISM_TYPES = %w(plant animal fungi)
        
        SUMMARY_EXECUTABLE_NAME = 'runWolfPsortSummary'
        
        # Given an amino acid sequence as a String and an organism type (plasnt/animal/fungi) as a String,
        # run a local version of WoLF_PSORT (which is assumed to be in the executable path) and
        # return a parsed report. Return nil if something untoward happens. 
        # 
        # A known problem is that it doesn't
        # work on sequences that are too short. For instance the sequence MRTLKTEVEKGFLSTMFVQELATPKG
        # prints out an error on the command line:
        # Modification of non-creatable array value attempted, subscript -1 at /home/ben/bioinfo/WoLFPSORT_package_v0.2/bin/psortModifiedForWolfFiles/psortModules/PsortFastaReader.pm line 440, <STDIN> line 1.
        def run(amino_acid_sequence_string, organism_type)
          fasta = ">wolf\n#{amino_acid_sequence_string}"
          
          output = Bio::Command.query_command([SUMMARY_EXECUTABLE_NAME, organism_type], fasta)
          return nil if output == '' or output.nil? # happens when the sequence is too short
          return Bio::PSORT::WoLF_PSORT::Report.parse_from_summary(organism_type, output.split("\n")[1])
        end
      end # class Wrapper
      
      # taken from http://wolfpsort.org/aboutWoLF_PSORT.html.en
      LOCATIONS = [
        'chlo',
        'cyto',
        'cysk',
        'E.R.',
        'extr',
        'golg',
        'lyso',
        'mito',
        'nucl',
        'pero',
        'plas',
        'vacu' 
      ]
      ORGANISM_TYPES = [
        'animal',
        'plant',
        'fungi'
      ]
      # Locations for each lineage were taken from Table 1 of:
      # Paul Horton, Keun-Joon Park, Takeshi Obayashi & Kenta Nakai,
      # "Protein Subcellular Localization Prediction with WoLF PSORT",
      # Proceedings of the 4th Annual Asia Pacific Bioinformatics Conference APBC06, Taipei, Taiwan. pp. 39-48, 2006.)
      ANIMAL_LOCATIONS = LOCATIONS.reject{|l| l=='chlo'}
      FUNGI_LOCATIONS = LOCATIONS.reject{|l| l=='chlo' or l=='lyso'}
      ANIMAL_LOCATIONS = LOCATIONS.reject{|l| l=='lyso'}
      
      class Report
        # Name of the sequence that has been analyzed, according
        # to WoLF_PSORT output
        attr_accessor :name
        
        # plant, fungal or animal as a string
        attr_accessor :organism_type
        
        # A hash of scores output, for example {'cyto' => 12}
        # keys of the hash are strings representing localisations
        # values of the hash are float output scores
        attr_accessor :score_hash
        
        def initialize(name=nil, organism_type=nil, score_hash={})
          @name = name
          @organism_type = organism_type
          @score_hash = score_hash
        end
      
        # Given an output line from a the runWolfPsortSummary script,
        # return a report with all the included information in it.
        def self.parse_from_summary(organism_type, line)
          line.strip!
          return nil if line.match(/^\#/) #ignore the first comment line
          
          rep = self.new
          rep.organism_type = organism_type
          
          line.split(', ').each_with_index do |fraction, index|
            splits = fraction.split(' ')
            if index == 0
              raise ArgumentError, "invalid format\n[#{line}]" if splits.length != 3
              rep.name = splits[0]
              rep.score_hash[splits[1]] = splits[2].to_f
            else
              raise ArgumentError, "invalid format\n[#{line}]" if splits.length != 2
              rep.score_hash[splits[0]] = splits[1].to_f
            end
          end
          
          return rep
        end
        
        # Return the string of the highest predicted localisation
        # recorded in the score hash
        def highest_predicted_localization
          @score_hash.max{ |a,b|
            a[1] <=> b[1]
          }[0]
        end
      end # class Report
    end # class WoLF_PSORT
  end # class PSORT
end # module BioSORT