import './style.sass'
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../../../components/ui/tabs"
import { Button } from "../../../components/ui/button"
import { Textarea } from '../../../components/ui/textarea';
import { Input } from '../../../components/ui/input';

function Report() {

    return (
        <>
            <Tabs defaultValue="public" className="w-[300px]">
                <TabsList>
                    <TabsTrigger value="public">Public</TabsTrigger>
                    <TabsTrigger value="private">Private</TabsTrigger>
                </TabsList>
                <TabsContent value="public" >
                    <div className='text-start p-1'>
                        <p>Send in a report <span className='text-amber-500'>Publicly</span></p>
                        <Input placeholder='Name' className="my-1"/>
                        <Textarea placeholder='details' className="my-1" />
                    </div>
                    <Button>Snitch</Button>

                </TabsContent>
                <TabsContent value="private">Change your password here.</TabsContent>
            </Tabs>

        </>
    )
}

export default Report