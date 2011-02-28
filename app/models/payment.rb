class Payment < ActiveRecord::Base
  # Constantes
  PAID_WITH = {
    :bonus => 'B',
    :cash => 'C'
  }.with_indifferent_access.freeze

  # Restricciones de los atributos
  attr_readonly :amount

  # Restricciones
  validates :amount, :presence => true, :numericality => {
    :greater_than_or_equal_to => 0 }
  validates :paid, :presence => true, :numericality => {
    :less_than_or_equal_to => :amount, :greater_than_or_equal_to => 0 }
  validates :paid_with, :presence => true,
    :inclusion => { :in => PAID_WITH.values },
    :length => { :maximum => 1 }

  # Relaciones
  belongs_to :payable, :polymorphic => true

  def initialize(attributes = nil)
    super(attributes)

    self.amount ||= 0.0
    self.paid ||= 0.0
    self.paid_with ||= PAID_WITH[:cash]
  end

  def paid_with_text
    I18n.t(:"view.payments.paid_with.#{PAID_WITH.invert[self.paid_with]}")
  end

  PAID_WITH.each do |paid_with_type, paid_with_value|
    define_method(:"#{paid_with_type}?") { self.paid_with == paid_with_value }
  end
end