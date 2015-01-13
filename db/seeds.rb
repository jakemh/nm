@branches = [
  "Marine Corps",
  "Navy",
  "Air Force",
  "Army",
  "Coast Guard"
]

@roles = {
  admin_role: {},
  mentor_role: {category: 0}
}

module Seed
  def each_with_print &block
    p "building #{block} from #{block.__method__}" 
    self.each &block
  end
end

def build_roles
  @roles.each do |k, options|
    r = Role.new :roleable => k.to_s.camelize.constantize.create(options)
    p "building #{k} => #{options} from #{__method__}" if r.save
  end
end


def build_branches
  @branches.each do |name|
    b = Branch.new(name: name)
    p "building #{name} from #{__method__}" if b.save
  end
end


build_roles()
build_branches()