class TarotCard {
  final String name;
  final String meaning;
  final String reversedMeaning;
  final String description;
  final String emoji;

  TarotCard({
    required this.name,
    required this.meaning,
    required this.reversedMeaning,
    required this.description,
    required this.emoji,
  });
}

class TarotData {
  static final List<TarotCard> majorArcana = [
    TarotCard(
      name: 'The Fool',
      emoji: '🃏',
      meaning: 'New beginnings, innocence, spontaneity, free spirit',
      reversedMeaning: 'Recklessness, taken advantage of, inconsideration',
      description: 'The Fool represents new beginnings and taking a leap of faith.',
    ),
    TarotCard(
      name: 'The Magician',
      emoji: '🎩',
      meaning: 'Manifestation, resourcefulness, power, inspired action',
      reversedMeaning: 'Manipulation, poor planning, untapped talents',
      description: 'The Magician represents the power to manifest your desires.',
    ),
    TarotCard(
      name: 'The High Priestess',
      emoji: '🌙',
      meaning: 'Intuition, sacred knowledge, divine feminine, subconscious',
      reversedMeaning: 'Secrets, disconnected from intuition, withdrawal',
      description: 'The High Priestess represents intuition and inner wisdom.',
    ),
    TarotCard(
      name: 'The Empress',
      emoji: '👑',
      meaning: 'Femininity, beauty, nature, nurturing, abundance',
      reversedMeaning: 'Creative block, dependence on others',
      description: 'The Empress represents abundance and maternal influence.',
    ),
    TarotCard(
      name: 'The Emperor',
      emoji: '⚔️',
      meaning: 'Authority, establishment, structure, father figure',
      reversedMeaning: 'Domination, excessive control, lack of discipline',
      description: 'The Emperor represents authority and structured power.',
    ),
    TarotCard(
      name: 'The Hierophant',
      emoji: '📿',
      meaning: 'Spiritual wisdom, tradition, conformity, institutions',
      reversedMeaning: 'Personal beliefs, freedom, challenging status quo',
      description: 'The Hierophant represents spiritual wisdom and tradition.',
    ),
    TarotCard(
      name: 'The Lovers',
      emoji: '💕',
      meaning: 'Love, harmony, relationships, values alignment',
      reversedMeaning: 'Self-love, disharmony, imbalance, misalignment',
      description: 'The Lovers represent love and meaningful relationships.',
    ),
    TarotCard(
      name: 'The Chariot',
      emoji: '🏇',
      meaning: 'Control, willpower, success, determination',
      reversedMeaning: 'Self-discipline, opposition, lack of direction',
      description: 'The Chariot represents willpower and determination.',
    ),
    TarotCard(
      name: 'Strength',
      emoji: '🦁',
      meaning: 'Strength, courage, persuasion, influence, compassion',
      reversedMeaning: 'Inner strength, self-doubt, low energy, raw emotion',
      description: 'Strength represents inner strength and courage.',
    ),
    TarotCard(
      name: 'The Hermit',
      emoji: '🕯️',
      meaning: 'Soul searching, introspection, inner guidance, solitude',
      reversedMeaning: 'Isolation, loneliness, withdrawal',
      description: 'The Hermit represents soul searching and introspection.',
    ),
    TarotCard(
      name: 'Wheel of Fortune',
      emoji: '☸️',
      meaning: 'Good luck, karma, life cycles, destiny, turning point',
      reversedMeaning: 'Bad luck, resistance to change, breaking cycles',
      description: 'The Wheel of Fortune represents destiny and life cycles.',
    ),
    TarotCard(
      name: 'Justice',
      emoji: '⚖️',
      meaning: 'Justice, fairness, truth, cause and effect, law',
      reversedMeaning: 'Unfairness, lack of accountability, dishonesty',
      description: 'Justice represents fairness and truth.',
    ),
    TarotCard(
      name: 'The Hanged Man',
      emoji: '🙃',
      meaning: 'Pause, surrender, letting go, new perspectives',
      reversedMeaning: 'Delays, resistance, stalling, indecision',
      description: 'The Hanged Man represents surrender and new perspectives.',
    ),
    TarotCard(
      name: 'Death',
      emoji: '💀',
      meaning: 'Endings, change, transformation, transition',
      reversedMeaning: 'Resistance to change, personal transformation, inner purging',
      description: 'Death represents transformation and new beginnings.',
    ),
    TarotCard(
      name: 'Temperance',
      emoji: '🌊',
      meaning: 'Balance, moderation, patience, purpose',
      reversedMeaning: 'Imbalance, excess, self-healing, re-alignment',
      description: 'Temperance represents balance and moderation.',
    ),
    TarotCard(
      name: 'The Devil',
      emoji: '😈',
      meaning: 'Shadow self, attachment, addiction, restriction',
      reversedMeaning: 'Releasing limiting beliefs, exploring dark thoughts, detachment',
      description: 'The Devil represents shadow self and attachments.',
    ),
    TarotCard(
      name: 'The Tower',
      emoji: '🗼',
      meaning: 'Sudden change, upheaval, chaos, revelation, awakening',
      reversedMeaning: 'Personal transformation, fear of change, averting disaster',
      description: 'The Tower represents sudden change and revelation.',
    ),
    TarotCard(
      name: 'The Star',
      emoji: '⭐',
      meaning: 'Hope, faith, purpose, renewal, spirituality',
      reversedMeaning: 'Lack of faith, despair, self-trust, disconnection',
      description: 'The Star represents hope and renewal.',
    ),
    TarotCard(
      name: 'The Moon',
      emoji: '🌕',
      meaning: 'Illusion, fear, anxiety, subconscious, intuition',
      reversedMeaning: 'Release of fear, repressed emotion, inner confusion',
      description: 'The Moon represents illusion and intuition.',
    ),
    TarotCard(
      name: 'The Sun',
      emoji: '☀️',
      meaning: 'Positivity, fun, warmth, success, vitality',
      reversedMeaning: 'Inner child, feeling down, overly optimistic',
      description: 'The Sun represents positivity and success.',
    ),
    TarotCard(
      name: 'Judgement',
      emoji: '📯',
      meaning: 'Judgement, rebirth, inner calling, absolution',
      reversedMeaning: 'Self-doubt, inner critic, ignoring the call',
      description: 'Judgement represents rebirth and inner calling.',
    ),
    TarotCard(
      name: 'The World',
      emoji: '🌍',
      meaning: 'Completion, accomplishment, travel, fulfillment',
      reversedMeaning: 'Seeking personal closure, short-cuts, delays',
      description: 'The World represents completion and fulfillment.',
    ),
  ];
}
