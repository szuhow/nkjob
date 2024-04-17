import os
import glob
import nuke


def reloadReadRanges():
# Get all nodes of class "Read" with name "IN1"
    read_nodes = [node for node in nuke.allNodes() if node.Class() == "Read" and node.name() == "IN1"]

    if not read_nodes:
        exit(0)

    # Execute 'reload' and set 'localizationPolicy' for each Read node
    for node in read_nodes:
        node['reload'].execute()
        node.knob('localizationPolicy').setValue('off')

        path, file = os.path.split(node.knob("file").getValue())
        files = glob.glob(path + "/*.exr")
        files.sort()

        first = int(files[0].split(".")[-2].split("_")[-1])
        last = int(files[-1].split(".")[-2].split("_")[-1])

        node.knob("first").setValue(first)
        node.knob("last").setValue(last)
        node.knob("origfirst").setValue(first)
        node.knob("origlast").setValue(last)

        node.knob('localizationPolicy').setValue('on')    
        nuke.Script_Knob.execute(node.knob('updateLocalization'))

nuke.addOnScriptLoad(reloadReadRanges)