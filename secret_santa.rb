require_relative 'participant'

elspeth = Participant.new('Elspeth')
emilie = Participant.new('Emilie', 'David')
nancy = Participant.new('Nancy', 'Michael')
michael = Participant.new('Michael', 'Nancy')
david = Participant.new('David', 'Emilie')

participants = [elspeth, emilie, nancy, michael, david]

the_hat = []

(the_hat << participants).flatten!

continue_matching = true
assignments = []

while continue_matching

  participants.each do |participant|
    # Start over if the only receiver left is the participant him or herself
    if the_hat.size == 1 && the_hat[0].name == participant.name
      break
    # Start over if the only receiver left is the giver's partner
  elsif the_hat.size == 1 && (!participant.partner.nil? && the_hat[0].name == participant.partner)
      break
    # Start over if the only receivers left are the participant him or herself and the participant's partner
    elsif the_hat.size == 2  && !participant.partner.nil?
      found_self = false
      found_partner = false
      the_hat.each do |recipient|
        if participant.partner == recipient.name
          found_partner = true
        end
        if participant.name == recipient.name
          found_self = true
        end
      end
      break if found_self && found_partner
    end

    keep_looking_for_individual_match = true
    while keep_looking_for_individual_match
      possible_match = the_hat.sample
      # retry if the possible_match is the giver or the giver's partner
      if possible_match.name == participant.name || (!participant.partner.nil? && possible_match.name == participant.partner)
      else
        assignments.push([participant, possible_match])
        keep_looking_for_individual_match = false
        the_hat.each_with_index do |recipient, index|
          if recipient.name == possible_match.name
            the_hat.delete_at(index)
            break
          end
        end
      end
    end
  end

  if the_hat.empty?
    continue_matching = false
  else
    assignments.clear
    the_hat.clear
    the_hat << participants.flatten!
  end
end

assignments.each do |combo|
  puts combo[0].name + ' will give a gift to ' + combo[1].name
end
