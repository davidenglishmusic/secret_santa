class Elf
  def match_participants(the_hat)
    get_valid_permutations(the_hat).sample
  end

  private

  def get_valid_permutations(the_hat)
    valid_permutations = []
    permutations = the_hat.permutation.to_a
    permutations.each do |permutation|
      all_valid_combinations = true
      the_hat.each_with_index do |participant, index|
        all_valid_combinations = false unless
          valid_combination?(participant, permutation[index])
      end
      valid_permutations.push(permutation) if all_valid_combinations
    end
    valid_permutations
  end

  def valid_combination?(participant, recipient)
    if participant.name == recipient.name ||
       participant.partner == recipient.name
      false
    else
      true
    end
  end
end
