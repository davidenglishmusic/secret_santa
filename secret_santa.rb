require_relative 'participant'

elspeth = Participant.new('Elspeth')
emilie = Participant.new('Emilie', 'David')
nancy = Participant.new('Nancy', 'Michael')
michael = Participant.new('Michael', 'Nancy')
david = Participant.new('David', 'Emilie')

givers = [elspeth, emilie, nancy, michael, david]

receivers = []

(receivers << givers).flatten!

continue_matching = true
assignments = []

while continue_matching

  givers.each do |giver|
    # Start over if the only receiver left is the giver him or herself
    if receivers.size == 1 && receivers[0].name == giver.name
      break
    # Start over if the only receiver left is the giver's partner
    elsif receivers.size == 1 && (!giver.partner.nil? && receivers[0].name == giver.partner)
      break
    # Start over if the only receivers left are the giver him or herself and the giver's partner
    elsif receivers.size == 2  && !giver.partner.nil?
      found_self = false
      found_partner = false
      receivers.each do |receiver|
        if giver.partner == receiver.name
          found_partner = true
        end
        if giver.name == receiver.name
          found_self = true
        end
      end
      break if found_self && found_partner
    end

    keep_looking_for_individual_match = true
    while keep_looking_for_individual_match
      possible_match = receivers.sample
      # retry if the possible_match is the giver or the giver's partner
      if possible_match.name == giver.name || (!giver.partner.nil? && possible_match.name == giver.partner)
      else
        assignments.push([giver, possible_match])
        keep_looking_for_individual_match = false
        receivers.each_with_index do |receiver, index|
          if receiver.name == possible_match.name
            receivers.delete_at(index)
            break
          end
        end
      end
    end
  end

  if receivers.empty?
    continue_matching = false
  else
    receivers.clear
    (receivers << givers).flatten!
  end
end

assignments.each do |combo|
  puts combo[0].name + ' will give a gift to ' + combo[1].name
end
