//
//  ExpandableText.swift
//  Foods With Friends
//
//  Created by Arianna Ridgeway (student LM) on 3/13/23.
//

import SwiftUI
//
//  ExpandableText.swift
//  fhZEaugi;.rS<aw
//
//  Created by Arianna Ridgeway (student LM) on 3/9/23.
//
//
//  ExpandableText.swift
//  kjdbhcwlerui
//
//  Created by Arianna Ridgeway (student LM) on 3/8/23.
//
struct ExpandableText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    private var text: String = ""

    let lineLimit: Int

    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
    }

    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? "read less" : " read more"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .lineLimit(expanded ? nil : lineLimit)
                .background(
                                    Text(text).lineLimit(lineLimit)
                                        .background(GeometryReader { visibleTextGeometry in
                                            ZStack { //large size zstack to contain any size of text
                                                Text(self.text)
                                                    .background(GeometryReader { fullTextGeometry in
                                                        Color.clear.onAppear {
                                                            self.truncated = fullTextGeometry.size.height > visibleTextGeometry.size.height
                                                        }
                                                    })
                                            }
                                            .frame(height: .greatestFiniteMagnitude)
                                        })
                                        .hidden() //keep hidden
                            )
                            if truncated {
                                Button(action: {
                                    withAnimation {
                                        expanded.toggle()
                                    }
                                }, label: {
                                    Text(moreLessText)
                                })
                            }
                        }
                    }
                }

struct ExpandableText_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableText("", lineLimit: 10)
    }
}
