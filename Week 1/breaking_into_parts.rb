# Original Method
def return_number(a)
  ((a / 2)**2) * (65 - (a / 2))
end

# After Editing
def childs_money_estimate_at_retirement(your_age)
  childs_age_estimate = your_age / 2
  childs_bank_estimate = childs_age_estimate**2
  childs_years_until_retirement = 65 - childs_age_estimate
  estimated_money_left = childs_bank_estimate * childs_years_until_retirement
  estimated_money_left
end

p return_number(30)
p return_number(50)

p childs_money_estimate_at_retirement(30)
p childs_money_estimate_at_retirement(50)
