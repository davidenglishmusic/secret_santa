class Elf

  def match_participants(the_hat)
    participants = the_hat.clone
    continue_matching = true
    assignments = []
    while continue_matching
      participants.each do |participant|
        if the_hat.size < 3
          break if !remaining_recipients_are_valid(the_hat, participant)
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
        return assignments
      else
        assignments.clear
        the_hat.clear
        the_hat = participants.clone
      end
    end
  end

  private

  def remaining_recipients_are_valid(the_hat, participant)
    # Start over if the only receiver left is the participant him or herself
    if the_hat.size == 1 && the_hat[0].name == participant.name
      puts "returning false for first condition"
      false
    # Start over if the only receiver left is the giver's partner
    elsif the_hat.size == 1 && (!participant.partner.nil? && the_hat[0].name == participant.partner)
      puts "returning false for second condition"
      false
    # Start over if the only receivers left are the participant him or herself and the participant's partner
    else the_hat.size == 2  && !participant.partner.nil?
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
      found_self && found_partner ? false : true
    end
  end
end
