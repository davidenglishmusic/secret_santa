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

assignments.each_with_index do |recipient, index|
  puts the_hat[index].name + ' will give a gift to ' + recipient.name
end
