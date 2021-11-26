# Covid vaccination in Greece by department.
# Data from gov.gr, 25 November 2021
# Not necessarily representative because recorded by
# vaccination department and by residence.
# See it just as an exercice of combining python and R i a script
import requests
url = 'https://data.gov.gr/api/v1/query/mdg_emvolio?date_from=2021-11-25&date_to=2021-11-25'
headers = {'Authorization':'Token insert-your-token-here'}
response = requests.get(url, headers=headers)
vaccinations=response.json()
