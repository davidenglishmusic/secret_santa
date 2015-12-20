class Elf
  def match_participants(the_hat)
    participants = the_hat.clone
    assignments = []
    while true
      participants.each do |participant|
        if the_hat.size < 3 && the_hat.size > 0
          break unless remaining_recipients_are_valid(the_hat, participant)
        end

        keep_looking_for_individual_match = true
        while keep_looking_for_individual_match
          possible_match = the_hat.sample
          # retry if the possible_match is the participant or the
          # participants's partner
          if possible_match.name == participant.name ||
             (!participant.partner.nil? &&
             possible_match.name == participant.partner)
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

      return assignments if the_hat.empty?

      assignments.clear
      the_hat.clear
      the_hat = participants.clone
    end
  end

  private

  def remaining_recipients_are_valid(the_hat, participant)
    # Start over if the only recipient left is the participant him or herself
    # or if the only recipient left is the participant's partner
    if the_hat.size == 1
      if the_hat[0].name == participant.name || (!participant.partner.nil? &&
        the_hat[0].name == participant.partner)
        false
      else
        true
      end
    # Start over if the only receivers left are the participant him or herself
    # and the participant's partner
    elsif the_hat.size == 2 && !participant.partner.nil?
      found_self = false
      found_partner = false
      the_hat.each do |recipient|
        found_partner = true if participant.partner == recipient.name
        found_self = true if participant.name == recipient.name
      end
      found_self && found_partner ? false : true
    else
      true
    end
  end
end
