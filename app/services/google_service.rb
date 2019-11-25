require "google_drive"

class GoogleService

  def self.export_sample()
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1-2cQ6VyGolcHvskOJ1gjgqLMG8tmppJbtjsECn2rh34").worksheets[0]
    ws['A1'] = "foo"
    ws['B2'] = "bar"
    
  end

  def self.save_entries_for(result)
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1-2cQ6VyGolcHvskOJ1gjgqLMG8tmppJbtjsECn2rh34").worksheets[0]
    # Date	Person	Teams	Email	Group/Client	Project	Minutes	Hours	Tags	Description	Billable
    #	Invoiced	Invoice Reference	Paid	Approved	Approved By	Year	WEEKnumb	Month	Days	FTE (Months)
    
    if ws.num_rows == 0
      ws.insert_rows(ws.num_rows + 1, [['Date', 'Person', 'Team', 'Group/Client',
        'Project','	Minutes','Hours','Tags','Description','Billable'
        'Invoiced','Invoice','Reference','Paid','Approved','Approved By',
        'Year','WEEKnumb','Month','Days','FTE (Months)']])
    end
    result.each do |entry|
      ws.insert_rows(ws.num_rows + 1, [[entry.description, entry.minutes, 
        entry.date, entry.user.first_name + '' + entry.user.last_name, entry.project.name,
        '=WEEKNUM(C' + (ws.num_rows + 1).to_s + ',1)']])
    end
    ws.save

  end
end
