require_relative 'participant'
require_relative 'elf'

elspeth = Participant.new('Elspeth')
emilie = Participant.new('Emilie', 'David')
nancy = Participant.new('Nancy', 'Michael')
michael = Participant.new('Michael', 'Nancy')
david = Participant.new('David', 'Emilie')

legolas = Elf.new

the_hat = [elspeth, emilie, nancy, michael, david]

assignments = legolas.match_participants(the_hat)

assignments.each do |combo|
  puts combo[0].name + ' will give a gift to ' + combo[1].name
end
