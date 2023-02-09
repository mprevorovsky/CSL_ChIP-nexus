import glob
import os

sam_files = glob.glob('./BAM_ChIP-nexus/*.barcode.gz.sam')
for i in sam_files:
  sam_file_in = open(i, 'r')
  sam_file_out = open(i[0:-4] + '.dedup.sam', 'w')

  lines = []
  lines_split = []
  IDs = []
  lines_dedup = []
  
  while True:
    line = sam_file_in.readline()
    if len(line) == 0:
      break
    if line[0] == '@':
      sam_file_out.writelines(line)
      sam_file_out.flush()
    else:
      lines.append(line)
      lines_split.append(line.split('\t'))
      current_UMI = lines_split[-1][0]
      break

  while True:
    line = sam_file_in.readline()
    if len(line) == 0:
      for j in range(len(lines)):
        line_flags = bin(int(lines_split[j][1]))
        if len(line_flags) >= 7:
          line_ID = lines_split[j][0] + line_flags[-5] + lines_split[j][2] + lines_split[j][3]
        else:
          line_ID = lines_split[j][0] + '0' + lines_split[j][2] + lines_split[j][3]
        if line_ID not in IDs:
          IDs.append(line_ID)
          lines_dedup.append(lines[j])
      sam_file_out.writelines(lines_dedup)
      sam_file_out.flush()
      break
    
    else:
      line_split = line.split('\t')
      if line_split[0] == current_UMI:
        lines.append(line)
        lines_split.append(line_split)
      else:
        for j in range(len(lines)):
          line_flags = bin(int(lines_split[j][1]))
          if len(line_flags) >= 7:
            line_ID = lines_split[j][0] + line_flags[-5] + lines_split[j][2] + lines_split[j][3]
          else:
            line_ID = lines_split[j][0] + '0' + lines_split[j][2] + lines_split[j][3]
          if line_ID not in IDs:
            IDs.append(line_ID)
            lines_dedup.append(lines[j])
        sam_file_out.writelines(lines_dedup)
        sam_file_out.flush()
    
        lines = [line]
        lines_split = [line_split]
        current_UMI = line_split[0]
        IDs = []
        lines_dedup = []

  sam_file_in.close()
#  os.remove(i)
  sam_file_out.close()

