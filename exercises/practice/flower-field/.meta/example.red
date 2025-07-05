Red [
	description: {"Flower Field" exercise solution for exercism platform}
	author: "BNAndras"
]

annotate: function [
    garden
][
    rows: length? garden
    cols: length? first garden
    result: []
    
    repeat i rows [
        marked-row: copy ""
        current-row: pick garden i
        
        repeat j cols [
            cell: pick current-row j
            
            either cell = #"*" [
                append marked-row "*"
            ][
                count: 0
                min-row: max 1 (i - 1)
                max-row: min rows (i + 1)
                min-col: max 1 (j - 1)
                max-col: min cols (j + 1)

				row-indices: collect [
					repeat k (max-row - min-row + 1) [keep min-row + k - 1]
				]
                col-indices: collect [
					repeat k (max-col - min-col + 1) [keep min-col + k - 1]
				]

				foreach ni row-indices [
                    foreach nj col-indices [
                        if not and~ ni = i nj = j [
                            neighbor-row: pick garden ni
                            neighbor: pick neighbor-row nj
                            if neighbor = #"*" [
                                count: count + 1
                            ]
                        ]
                    ]
                ]
                
                either count = 0 [
                    append marked-row " "
                ][
                    append marked-row to string! count
                ]
            ]
        ]
        
        append result marked-row
    ]
    
    result
]