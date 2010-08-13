#Isotonic regression technique for Ruby (deletion free algorithm)
#reverse all arrays for antitonic regression(monotonic decreasing)
require 'rational'
class Monoi
  attr_accessor :scores, :sweights, :qweights, :qvalues

     def initialize(*args)
    (@scores, @sweights, @qweights, @qvalues) = args
  end

  def regress
    qvalues_tmp = Array.new(@qvalues.length)
    qweights_tmp = Array.new(@qweights.length)
    done = false
    while !done
      done = true
      i = 0 #incremement variable for old array
      j = 0 #increment variable for new array (tmp)
      size = @qvalues.length
      qvalues_tmp[0] = @qvalues[0]
      qweights_tmp[0] = @qweights[0]
      until i  > size-2
        if qvalues_tmp[j].to_f < @qvalues[i + 1].to_f then
            qvalues_tmp[j + 1] = @qvalues[i + 1]
            qweights_tmp[j + 1] = @qweights[i + 1]  
            i += 1
            j += 1
          else
            done = false
            x = Rational((qvalues_tmp[j].to_f * qweights_tmp[j].to_f + @qvalues[i + 1].to_f * @qweights[i + 1].to_f)/(qweights_tmp[j].to_f + @qweights[i + 1].to_f)) #nix the to_f
            qvalues_tmp[j] = x.to_f
            qweights_tmp[j] = Rational(qweights_tmp[j].to_f + @qweights[i + 1].to_f)
            i += 1
        end
      end
      i = 0
      @qvalues = qvalues_tmp
      @qweights = qweights_tmp
      @qvalues.compact!
      @qweights.compact!
      qvalues_tmp = Array.new(qvalues.size)
      qweights_tmp = Array.new(qvalues.size)
    end
    expand_qvalues_and_qweights!
  end
  def expand_qvalues_and_qweights!
    final_qvalues = []
    final_qweights = []
    qvalue_cnt = 0
    @qweights.each do |weight|
      weight = weight.to_i
      weight.times do 
        final_qweights << 1
        final_qvalues << @qvalues[qvalue_cnt]
      end
    qvalue_cnt += 1
    end
    @qweights = final_qweights
    @qvalues = final_qvalues
  end
  def displayscores
    puts @scores.to_s
    puts @sweights.to_s
  end
  def displayqvalues
    puts @qvalues.to_s
    puts "display"
    puts @qweights.to_s
  end
end
