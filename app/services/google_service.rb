require "google_drive"

class GoogleService

  def self.export_sample()
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1-2cQ6VyGolcHvskOJ1gjgqLMG8tmppJbtjsECn2rh34").worksheets[1]
    ws['A1'] = "Alishba"
    ws['B1'] = "Nauman"
    ws.save
    
  end

  def self.save_entries_for(result)
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1-2cQ6VyGolcHvskOJ1gjgqLMG8tmppJbtjsECn2rh34").worksheets[0]

      if ws.num_rows == 0
        ws.insert_rows(ws.num_rows + 1, [['NokoID', 'Date', 'Person', 'Team', 'Email', 'Group/Client','Project','	Minutes','Hours','Tags','Description','Billable',
          'Invoiced','Invoice Reference','Paid','Approved','Approved By',
          'Year','WEEKnumb','Month','Days','FTE (Months)']])
      end
  

    result.each do |entry|
      ws.insert_rows(ws.num_rows + 1, [[
        entry.id,
        entry.date,
        entry.user.first_name + ' ' + entry.user.last_name,
        '',
        entry.user.email,
        '',
        entry.project.name,
        entry.minutes, 
        '=CONVERT('+entry.minutes.to_s+', "mn"; "hr")',
        entry.tags.map(&:formatted_name).join(','),
        entry.description,
        entry.billable ? 'yes' : 'no',
        entry.invoiced ? 'yes' : 'no',
        '',
        entry.invoiced_at ? entry.invoiced_at : 'no',
        entry.approved_at ? entry.approved_at : 'no',
        entry.approved_by,
        '=YEAR(B' + (ws.num_rows + 1).to_s + ')',
        '=MONTH(B' + (ws.num_rows + 1).to_s + ')',
        '=WEEKNUM(D' + (ws.num_rows + 1).to_s + ',1)',
        '=I' + (ws.num_rows + 1).to_s + '/7.6',
        '=U' + (ws.num_rows + 1).to_s + '/20.75'
        ]])
    end
    ws.save

  end
end
