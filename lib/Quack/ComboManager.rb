require "singleton"

class ComboManager
  include Singleton

  private
    attr_accessor :combo_list

  public

  def initialize
    @combo_list = [
      {
        items: [:duck, :egg],
        action: lambda { 
          puts "You give the egg to the duck.\nThe duck quacks appreciatively."
          puts "
               __
             <(o )___
              ( ._> /
               `---'  
          ".gsub('\\') { '\\\\' }
          exit }
      }
    ]
  end

  def use(item1, item2)
    if !(item1 && item2)
      puts "You can't do that."
      return nil
    end

    the_combo = combo_list.find { |combo| ([item1, item2] - combo[:items]).empty? }
    if the_combo
      puts
      the_combo[:action].call
    end
  end
end
