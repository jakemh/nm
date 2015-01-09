# define roles
Role.create :roleable => AdminRole.create()
Role.create :roleable => MentorRole.create(category: 0)
